package org.example;

import com.intuit.karate.junit5.Karate;

public class TestWithSetupKarate {

  @Karate.Test
  public Karate testSucceed() {
    return Karate.run("classpath:org/example/test_with_setup.feature");
  }
}
