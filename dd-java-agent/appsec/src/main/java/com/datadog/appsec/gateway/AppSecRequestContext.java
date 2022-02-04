package com.datadog.appsec.gateway;

import com.datadog.appsec.event.data.Address;
import com.datadog.appsec.event.data.DataBundle;
import com.datadog.appsec.event.data.StringKVPair;
import com.datadog.appsec.report.raw.events.AppSecEvent100;
import com.datadog.appsec.util.StandardizedLogging;
import datadog.trace.api.TraceSegment;
import datadog.trace.api.http.StoredBodySupplier;
import io.sqreen.powerwaf.Additive;
import java.io.Closeable;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// TODO: different methods to be called by different parts perhaps splitting it would make sense
// or at least create separate interfaces
public class AppSecRequestContext implements DataBundle, Closeable {
  private static final Logger log = LoggerFactory.getLogger(AppSecRequestContext.class);

  // Values MUST be lowercase! Lookup with Ignore Case
  // was removed due performance reason
  public static final Set<String> HEADERS_ALLOW_LIST =
      new TreeSet<>(
          Arrays.asList(
              "x-forwarded-for",
              "x-client-ip",
              "x-real-ip",
              "x-forwarded",
              "x-cluster-client-ip",
              "forwarded-for",
              "forwarded",
              "via",
              "client-ip",
              "true-client-ip",
              "content-length",
              "content-type",
              "content-encoding",
              "content-language",
              "host",
              "user-agent",
              "accept",
              "accept-encoding",
              "accept-language"));

  private final ConcurrentHashMap<Address<?>, Object> persistentData = new ConcurrentHashMap<>();
  private Collection<AppSecEvent100> collectedEvents; // guarded by this

  // assume these will always be written and read by the same thread
  private String scheme;
  private String method;
  private String savedRawURI;
  private final Map<String, List<String>> requestHeaders = new LinkedHashMap<>();
  private final Map<String, List<String>> responseHeaders = new LinkedHashMap<>();
  private List<StringKVPair> collectedCookies = new ArrayList<>(4);
  private boolean finishedRequestHeaders;
  private boolean finishedResponseHeaders;
  private String peerAddress;
  private int peerPort;

  private volatile StoredBodySupplier storedRequestBodySupplier;

  private int responseStatus;
  private boolean blocked;

  private Additive additive;

  // to be called by the Event Dispatcher
  public void addAll(DataBundle newData) {
    for (Map.Entry<Address<?>, Object> entry : newData) {
      Address<?> address = entry.getKey();
      Object value = entry.getValue();
      if (value == null) {
        log.warn("Address {} ignored, because contains null value.", address);
        continue;
      }
      Object prev = persistentData.putIfAbsent(address, value);
      if (prev != null) {
        log.warn("Illegal attempt to replace context value for {}", address);
      }
      if (log.isDebugEnabled()) {
        StandardizedLogging.addressPushed(log, address);
      }
    }
  }

  public Additive getAdditive() {
    return additive;
  }

  public void setAdditive(Additive additive) {
    this.additive = additive;
  }

  /* Implementation of DataBundle */

  @Override
  public boolean hasAddress(Address<?> addr) {
    return persistentData.containsKey(addr);
  }

  @Override
  public Collection<Address<?>> getAllAddresses() {
    return persistentData.keySet();
  }

  @Override
  public int size() {
    return persistentData.size();
  }

  @Override
  @SuppressWarnings("unchecked")
  public <T> T get(Address<T> addr) {
    return (T) persistentData.get(addr);
  }

  @Override
  public Iterator<Map.Entry<Address<?>, Object>> iterator() {
    return persistentData.entrySet().iterator();
  }

  /* Interface for use of GatewayBridge */

  String getScheme() {
    return scheme;
  }

  void setScheme(String scheme) {
    this.scheme = scheme;
  }

  String getMethod() {
    return method;
  }

  void setMethod(String method) {
    this.method = method;
  }

  String getSavedRawURI() {
    return savedRawURI;
  }

  void setRawURI(String savedRawURI) {
    if (this.savedRawURI != null) {
      throw new IllegalStateException("Raw URI set already");
    }
    this.savedRawURI = savedRawURI;
  }

  void addRequestHeader(String name, String value) {
    if (finishedRequestHeaders) {
      throw new IllegalStateException("Request headers were said to be finished before");
    }

    if (name == null || value == null) {
      return;
    }

    List<String> strings =
        requestHeaders.computeIfAbsent(name.toLowerCase(), h -> new ArrayList<>(1));
    strings.add(value);
  }

  void finishRequestHeaders() {
    this.finishedRequestHeaders = true;
  }

  boolean isFinishedRequestHeaders() {
    return finishedRequestHeaders;
  }

  Map<String, List<String>> getRequestHeaders() {
    return requestHeaders;
  }

  void addResponseHeader(String name, String value) {
    if (finishedResponseHeaders) {
      throw new IllegalStateException("Response headers were said to be finished before");
    }

    if (name == null || value == null) {
      return;
    }

    List<String> strings =
        responseHeaders.computeIfAbsent(name.toLowerCase(), h -> new ArrayList<>(1));
    strings.add(value);
  }

  public void finishResponseHeaders() {
    this.finishedResponseHeaders = true;
  }

  public boolean isFinishedResponseHeaders() {
    return finishedResponseHeaders;
  }

  Map<String, List<String>> getResponseHeaders() {
    return responseHeaders;
  }

  void addCookie(StringKVPair cookie) {
    if (finishedRequestHeaders) {
      throw new IllegalStateException("Request headers were said to be finished before");
    }
    collectedCookies.add(cookie);
  }

  List<StringKVPair> getCollectedCookies() {
    return collectedCookies;
  }

  String getPeerAddress() {
    return peerAddress;
  }

  void setPeerAddress(String peerAddress) {
    this.peerAddress = peerAddress;
  }

  public int getPeerPort() {
    return peerPort;
  }

  public void setPeerPort(int peerPort) {
    this.peerPort = peerPort;
  }

  void setStoredRequestBodySupplier(StoredBodySupplier storedRequestBodySupplier) {
    this.storedRequestBodySupplier = storedRequestBodySupplier;
  }

  public int getResponseStatus() {
    return responseStatus;
  }

  public void setResponseStatus(int responseStatus) {
    this.responseStatus = responseStatus;
  }

  public boolean isBlocked() {
    return blocked;
  }

  public void setBlocked(boolean blocked) {
    this.blocked = blocked;
  }

  @Override
  public void close() {
    // currently no-op
  }

  /* end interface for GatewayBridge */

  /* Should be accessible from the modules */

  /** @return the portion of the body read so far, if any */
  public CharSequence getStoredRequestBody() {
    StoredBodySupplier storedRequestBodySupplier = this.storedRequestBodySupplier;
    if (storedRequestBodySupplier == null) {
      return null;
    }
    return storedRequestBodySupplier.get();
  }

  public void reportEvents(Collection<AppSecEvent100> events, TraceSegment traceSegment) {
    for (AppSecEvent100 event : events) {
      StandardizedLogging.attackDetected(log, event);
    }
    synchronized (this) {
      if (this.collectedEvents == null) {
        this.collectedEvents = new ArrayList<>();
      }
      try {
        this.collectedEvents.addAll(events);
      } catch (UnsupportedOperationException e) {
        throw new IllegalStateException("Events cannot be added anymore");
      }
    }
  }

  Collection<AppSecEvent100> transferCollectedEvents() {
    Collection<AppSecEvent100> events;
    synchronized (this) {
      events = this.collectedEvents;
      this.collectedEvents = Collections.emptyList();
    }
    if (events != null) {
      return events;
    } else {
      return Collections.emptyList();
    }
  }
}
