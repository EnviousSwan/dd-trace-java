package opentelemetry14.context

import datadog.trace.agent.test.AgentTestRunner
import datadog.trace.api.DDSpanId
import io.opentelemetry.api.GlobalOpenTelemetry
import io.opentelemetry.api.trace.Span
import io.opentelemetry.context.Context
import io.opentelemetry.context.ContextKey
import io.opentelemetry.context.ThreadLocalContextStorage
import spock.lang.Subject

import static datadog.trace.bootstrap.instrumentation.api.ScopeSource.MANUAL
import static datadog.trace.instrumentation.opentelemetry14.context.OtelContext.DATADOG_CONTEXT_ROOT_SPAN_KEY
import static datadog.trace.instrumentation.opentelemetry14.context.OtelContext.OTEL_CONTEXT_SPAN_KEY
import static datadog.trace.instrumentation.opentelemetry14.trace.OtelConventions.DEFAULT_OPERATION_NAME

class ContextTest extends AgentTestRunner {
  @Subject
  def tracer = GlobalOpenTelemetry.get().tracerProvider.get("context-instrumentation")

  @Override
  void configurePreAgent() {
    super.configurePreAgent()

    injectSysConfig("dd.integration.opentelemetry.experimental.enabled", "true")
  }

  def "test Span.current/makeCurrent()"() {
    setup:
    def builder = tracer.spanBuilder("some-name")
    def otelSpan = builder.startSpan()

    when:
    def currentSpan = Span.current()

    then:
    currentSpan != null
    currentSpan.spanContext.traceId == "00000000000000000000000000000000"
    currentSpan.spanContext.spanId == "0000000000000000"

    when:
    def scope = otelSpan.makeCurrent()
    currentSpan = Span.current()

    then:
    currentSpan == otelSpan

    when:
    def ddSpan = TEST_TRACER.startSpan("dd-api", "other-name")
    def ddScope = TEST_TRACER.activateSpan(ddSpan, MANUAL)
    currentSpan = Span.current()

    then:
    currentSpan.spanContext.traceId == ddSpan.traceId.toHexString()
    currentSpan.spanContext.spanId == DDSpanId.toHexStringPadded(ddSpan.spanId)

    cleanup:
    ddScope.close()
    ddSpan.finish()
    scope.close()
    otelSpan.end()
  }

  def "test Context.makeCurrent() to activate a span without prior active span"() {
    setup:
    def builder = tracer.spanBuilder("some-name")
    def otelSpan = builder.startSpan()

    when:
    def currentSpan = Span.current()

    then:
    currentSpan != null
    !currentSpan.spanContext.isValid()

    when:
    def contextWithSpan = Context.current().with(otelSpan)
    def scope = contextWithSpan.makeCurrent()
    currentSpan = Span.current()

    then:
    currentSpan == otelSpan

    when:
    scope.close()
    currentSpan = Span.current()

    then:
    currentSpan != null
    !currentSpan.spanContext.isValid()

    cleanup:
    otelSpan.end()
  }

  def "test Context.makeCurrent() to activate a span with another currently active span"() {
    setup:
    def ddSpan = TEST_TRACER.startSpan("dd-api", "some-name")
    def ddScope = TEST_TRACER.activateSpan(ddSpan, MANUAL)
    def builder = tracer.spanBuilder("other-name")
    def otelSpan = builder.startSpan()

    when:
    def currentSpan = Span.current()

    then:
    currentSpan != null
    currentSpan.spanContext.traceId == ddSpan.traceId.toHexStringPadded(32)
    currentSpan.spanContext.spanId == DDSpanId.toHexStringPadded(ddSpan.spanId)

    when:
    def contextWithSpan = Context.current().with(otelSpan)
    def scope = contextWithSpan.makeCurrent()
    currentSpan = Span.current()

    then:
    currentSpan == otelSpan

    when:
    scope.close()
    currentSpan = Span.current()

    then:
    currentSpan != null
    currentSpan.spanContext.traceId == ddSpan.traceId.toHexStringPadded(32)
    currentSpan.spanContext.spanId == DDSpanId.toHexStringPadded(ddSpan.spanId)

    cleanup:
    otelSpan.end()
    ddScope.close()
    ddSpan.finish()
  }

  def "test Context.makeCurrent() to activate an already active span"() {
    when:
    def ddSpan = TEST_TRACER.startSpan("dd-api", "some-name")
    def ddScope = TEST_TRACER.activateSpan(ddSpan, MANUAL)
    def currentSpan = Span.current()

    then:
    currentSpan != null
    currentSpan.spanContext.traceId == ddSpan.traceId.toHexStringPadded(32)
    currentSpan.spanContext.spanId == DDSpanId.toHexStringPadded(ddSpan.spanId)

    when:
    def contextWithSpan = Context.current().with(currentSpan)
    def scope = contextWithSpan.makeCurrent()
    currentSpan = Span.current()

    then:
    currentSpan != null
    currentSpan.spanContext.traceId == ddSpan.traceId.toHexStringPadded(32)
    currentSpan.spanContext.spanId == DDSpanId.toHexStringPadded(ddSpan.spanId)

    when:
    scope.close()
    currentSpan = Span.current()

    then:
    currentSpan != null
    currentSpan.spanContext.traceId == ddSpan.traceId.toHexStringPadded(32)
    currentSpan.spanContext.spanId == DDSpanId.toHexStringPadded(ddSpan.spanId)

    when:
    ddScope.close()
    ddSpan.finish()
    currentSpan = Span.current()

    then:
    currentSpan != null
    !currentSpan.spanContext.isValid()
  }

  def "test clearing context"() {
    when:
    def rootScope = Context.root().makeCurrent()
    then:
    Context.current() == Context.root()
    cleanup:
    rootScope.close()
  }

  def "test mixing manual and OTel instrumentation"() {
    setup:
    def otelParentSpan = tracer.spanBuilder("some-name").startSpan()

    when:
    def otelParentScope = otelParentSpan.makeCurrent()
    def activeSpan = TEST_TRACER.activeSpan()

    then:
    activeSpan.operationName == DEFAULT_OPERATION_NAME
    activeSpan.resourceName == "some-name"
    DDSpanId.toHexStringPadded(activeSpan.spanId) == otelParentSpan.getSpanContext().spanId

    when:
    def ddChildSpan = TEST_TRACER.startSpan("dd-api", "other-name")
    def ddChildScope = TEST_TRACER.activateSpan(ddChildSpan, MANUAL)
    def current = Span.current()

    then:
    DDSpanId.toHexStringPadded(ddChildSpan.spanId) == current.getSpanContext().spanId

    when:
    def otelGrandChildSpan = tracer.spanBuilder("another-name").startSpan()
    def otelGrandChildScope= otelGrandChildSpan.makeCurrent()
    activeSpan = TEST_TRACER.activeSpan()

    then:
    activeSpan.operationName == DEFAULT_OPERATION_NAME
    activeSpan.resourceName == "another-name"
    DDSpanId.toHexStringPadded(activeSpan.spanId) == otelGrandChildSpan.getSpanContext().spanId

    when:
    otelGrandChildScope.close()
    otelGrandChildSpan.end()
    ddChildScope.close()
    ddChildSpan.finish()
    otelParentScope.close()
    otelParentSpan.end()

    then:
    assertTraces(1) {
      trace(3) {
        span {
          parent()
          operationName DEFAULT_OPERATION_NAME
          resourceName "some-name"
        }
        span {
          childOfPrevious()
          operationName "other-name"
        }
        span {
          childOfPrevious()
          operationName DEFAULT_OPERATION_NAME
          resourceName "another-name"
        }
      }
    }
  }

  def "test context spans retrieval"() {
    setup:
    def parentSpan = tracer.spanBuilder("some-name").startSpan()
    def parentScope = parentSpan.makeCurrent()
    def currentSpanKey = ContextKey.named(OTEL_CONTEXT_SPAN_KEY)
    def rootSpanKey = ContextKey.named(DATADOG_CONTEXT_ROOT_SPAN_KEY)

    when:
    def current = Context.current()

    then:
    current.get(currentSpanKey) == parentSpan
    current.get(rootSpanKey) == parentSpan

    when:
    def childSpan = tracer.spanBuilder("other-name").startSpan()
    def childScope = childSpan.makeCurrent()
    current = Context.current()

    then:
    current.get(currentSpanKey) == childSpan
    current.get(rootSpanKey) == parentSpan

    when:
    childScope.close()
    childSpan.end()
    current = Context.current()

    then:
    current.get(currentSpanKey) == parentSpan
    current.get(rootSpanKey) == parentSpan

    cleanup:
    parentScope.close()
    parentSpan.end()
  }

  @Override
  void cleanup() {
    // Test for context leak
    assert Context.current() == Context.root()
    // Safely reset OTel context storage
    ThreadLocalContextStorage.THREAD_LOCAL_STORAGE.remove()
  }
}
