[ {
  "type" : "span",
  "version" : 1,
  "content" : {
    "trace_id" : ${content_trace_id},
    "span_id" : ${content_span_id},
    "parent_id" : ${content_parent_id},
    "service" : "test-maven-service",
    "name" : "cucumber.step",
    "resource" : "I add {int} and {int}",
    "start" : ${content_start},
    "duration" : ${content_duration},
    "error" : 0,
    "metrics" : { },
    "meta" : {
      "_dd.p.tid" : ${content_meta__dd_p_tid},
      "library_version" : ${content_meta_library_version},
      "component" : "cucumber",
      "step.location" : "datadog.smoke.calculator.CalculatorSteps.adding(int,int)",
      "step.type" : "io.cucumber.java.JavaStepDefinition",
      "step.arguments" : "[4, 5]",
      "step.name" : "I add {int} and {int}",
      "env" : "integration-test",
      "runtime-id" : ${content_meta_runtime_id},
      "language" : "jvm"
    }
  }
}, {
  "type" : "test_session_end",
  "version" : 1,
  "content" : {
    "test_session_id" : ${content_test_session_id},
    "service" : "test-maven-service",
    "name" : "maven.test_session",
    "resource" : "Maven Smoke Tests Project",
    "start" : ${content_start_2},
    "duration" : ${content_duration_2},
    "error" : 0,
    "metrics" : {
      "process_id" : ${content_metrics_process_id},
      "_dd.profiling.enabled" : 0,
      "_dd.trace_span_attribute_schema" : 0,
      "test.code_coverage.lines_pct" : 0
    },
    "meta" : {
      "_dd.p.tid" : ${content_meta__dd_p_tid_2},
      "os.architecture" : ${content_meta_os_architecture},
      "_dd.tracer_host" : ${content_meta__dd_tracer_host},
      "test.status" : "pass",
      "ci.workspace_path" : ${content_meta_ci_workspace_path},
      "language" : "jvm",
      "runtime.name" : ${content_meta_runtime_name},
      "os.platform" : ${content_meta_os_platform},
      "os.version" : ${content_meta_os_version},
      "library_version" : ${content_meta_library_version},
      "span.kind" : "test_session_end",
      "runtime.version" : ${content_meta_runtime_version},
      "runtime-id" : ${content_meta_runtime_id_2},
      "test.type" : "test",
      "test_session.name" : "mvn -B test",
      "env" : "integration-test",
      "runtime.vendor" : ${content_meta_runtime_vendor},
      "component" : "maven",
      "test.code_coverage.enabled" : "true",
      "test.toolchain" : ${content_meta_test_toolchain},
      "test.command" : "mvn -B test",
      "test.framework_version" : "5.4.0",
      "test.framework" : "cucumber"
    }
  }
}, {
  "type" : "test_module_end",
  "version" : 1,
  "content" : {
    "test_session_id" : ${content_test_session_id},
    "test_module_id" : ${content_test_module_id},
    "service" : "test-maven-service",
    "name" : "maven.test_module",
    "resource" : "Maven Smoke Tests Project maven-surefire-plugin default-test",
    "start" : ${content_start_3},
    "duration" : ${content_duration_3},
    "error" : 0,
    "metrics" : {
      "test.code_coverage.lines_pct" : 0
    },
    "meta" : {
      "_dd.p.tid" : ${content_meta__dd_p_tid_3},
      "test.type" : "test",
      "os.architecture" : ${content_meta_os_architecture},
      "test.module" : "Maven Smoke Tests Project maven-surefire-plugin default-test",
      "test.status" : "pass",
      "test_session.name" : "mvn -B test",
      "ci.workspace_path" : ${content_meta_ci_workspace_path},
      "runtime.name" : ${content_meta_runtime_name},
      "env" : "integration-test",
      "runtime.vendor" : ${content_meta_runtime_vendor},
      "os.platform" : ${content_meta_os_platform},
      "os.version" : ${content_meta_os_version},
      "library_version" : ${content_meta_library_version},
      "component" : "maven",
      "test.code_coverage.enabled" : "true",
      "span.kind" : "test_module_end",
      "test.execution" : "maven-surefire-plugin:test:default-test",
      "runtime.version" : ${content_meta_runtime_version},
      "test.command" : "mvn -B test",
      "test.framework_version" : "5.4.0",
      "test.framework" : "cucumber",
      "runtime-id" : ${content_meta_runtime_id_2},
      "language" : "jvm"
    }
  }
}, {
  "type" : "span",
  "version" : 1,
  "content" : {
    "trace_id" : ${content_trace_id},
    "span_id" : ${content_span_id_2},
    "parent_id" : ${content_parent_id},
    "service" : "test-maven-service",
    "name" : "cucumber.step",
    "resource" : "a calculator I just turned on",
    "start" : ${content_start_4},
    "duration" : ${content_duration_4},
    "error" : 0,
    "metrics" : { },
    "meta" : {
      "_dd.p.tid" : ${content_meta__dd_p_tid_4},
      "library_version" : ${content_meta_library_version},
      "component" : "cucumber",
      "step.name" : "a calculator I just turned on",
      "env" : "integration-test",
      "step.location" : "datadog.smoke.calculator.CalculatorSteps.a_calculator_I_just_turned_on()",
      "step.type" : "io.cucumber.java.JavaStepDefinition",
      "runtime-id" : ${content_meta_runtime_id},
      "language" : "jvm"
    }
  }
}, {
  "type" : "test_suite_end",
  "version" : 1,
  "content" : {
    "test_session_id" : ${content_test_session_id},
    "test_module_id" : ${content_test_module_id},
    "test_suite_id" : ${content_test_suite_id},
    "service" : "test-maven-service",
    "name" : "junit.test_suite",
    "resource" : "classpath:datadog/smoke/basic_arithmetic.feature:Basic Arithmetic",
    "start" : ${content_start_5},
    "duration" : ${content_duration_5},
    "error" : 0,
    "metrics" : {
      "process_id" : ${content_metrics_process_id_2},
      "_dd.profiling.enabled" : 0,
      "_dd.trace_span_attribute_schema" : 0
    },
    "meta" : {
      "_dd.p.tid" : ${content_meta__dd_p_tid_5},
      "os.architecture" : ${content_meta_os_architecture},
      "_dd.tracer_host" : ${content_meta__dd_tracer_host},
      "test.module" : "Maven Smoke Tests Project maven-surefire-plugin default-test",
      "test.status" : "pass",
      "ci.workspace_path" : ${content_meta_ci_workspace_path},
      "language" : "jvm",
      "runtime.name" : ${content_meta_runtime_name},
      "os.platform" : ${content_meta_os_platform},
      "os.version" : ${content_meta_os_version},
      "library_version" : ${content_meta_library_version},
      "span.kind" : "test_suite_end",
      "test.suite" : "classpath:datadog/smoke/basic_arithmetic.feature:Basic Arithmetic",
      "runtime.version" : ${content_meta_runtime_version},
      "runtime-id" : ${content_meta_runtime_id},
      "test.type" : "test",
      "test_session.name" : "mvn -B test",
      "env" : "integration-test",
      "runtime.vendor" : ${content_meta_runtime_vendor},
      "component" : "junit",
      "test.framework_version" : "5.4.0",
      "test.framework" : "cucumber"
    }
  }
}, {
  "type" : "test",
  "version" : 2,
  "content" : {
    "trace_id" : ${content_trace_id},
    "span_id" : ${content_parent_id},
    "parent_id" : ${content_parent_id_2},
    "test_session_id" : ${content_test_session_id},
    "test_module_id" : ${content_test_module_id},
    "test_suite_id" : ${content_test_suite_id},
    "service" : "test-maven-service",
    "name" : "junit.test",
    "resource" : "classpath:datadog/smoke/basic_arithmetic.feature:Basic Arithmetic.Addition",
    "start" : ${content_start_6},
    "duration" : ${content_duration_6},
    "error" : 0,
    "metrics" : {
      "process_id" : ${content_metrics_process_id_2},
      "_dd.profiling.enabled" : 0,
      "_dd.trace_span_attribute_schema" : 0
    },
    "meta" : {
      "_dd.p.tid" : ${content_meta__dd_p_tid_6},
      "os.architecture" : ${content_meta_os_architecture},
      "_dd.tracer_host" : ${content_meta__dd_tracer_host},
      "test.module" : "Maven Smoke Tests Project maven-surefire-plugin default-test",
      "test.status" : "pass",
      "ci.workspace_path" : ${content_meta_ci_workspace_path},
      "language" : "jvm",
      "runtime.name" : ${content_meta_runtime_name},
      "os.platform" : ${content_meta_os_platform},
      "os.version" : ${content_meta_os_version},
      "library_version" : ${content_meta_library_version},
      "test.name" : "Addition",
      "span.kind" : "test",
      "test.suite" : "classpath:datadog/smoke/basic_arithmetic.feature:Basic Arithmetic",
      "runtime.version" : ${content_meta_runtime_version},
      "runtime-id" : ${content_meta_runtime_id},
      "test.type" : "test",
      "test_session.name" : "mvn -B test",
      "env" : "integration-test",
      "runtime.vendor" : ${content_meta_runtime_vendor},
      "component" : "junit",
      "test.framework_version" : "5.4.0",
      "test.framework" : "cucumber"
    }
  }
}, {
  "type" : "span",
  "version" : 1,
  "content" : {
    "trace_id" : ${content_trace_id},
    "span_id" : ${content_span_id_3},
    "parent_id" : ${content_parent_id},
    "service" : "test-maven-service",
    "name" : "cucumber.step",
    "resource" : "the result is {int}",
    "start" : ${content_start_7},
    "duration" : ${content_duration_7},
    "error" : 0,
    "metrics" : { },
    "meta" : {
      "_dd.p.tid" : ${content_meta__dd_p_tid_7},
      "library_version" : ${content_meta_library_version},
      "component" : "cucumber",
      "step.location" : "datadog.smoke.calculator.CalculatorSteps.the_result_is(double)",
      "step.type" : "io.cucumber.java.JavaStepDefinition",
      "step.arguments" : "[9]",
      "step.name" : "the result is {int}",
      "env" : "integration-test",
      "runtime-id" : ${content_meta_runtime_id},
      "language" : "jvm"
    }
  }
} ]