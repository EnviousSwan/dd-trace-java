[ {
  "type" : "test_session_end",
  "version" : 1,
  "content" : {
    "test_session_id" : ${content_test_session_id},
    "service" : "worker.org.gradle.process.internal.worker.gradleworkermain",
    "name" : "junit.test_session",
    "resource" : "junit-4.10",
    "start" : ${content_start},
    "duration" : ${content_duration},
    "error" : 0,
    "metrics" : {
      "process_id" : ${content_metrics_process_id},
      "_dd.profiling.enabled" : 0,
      "_dd.trace_span_attribute_schema" : 0
    },
    "meta" : {
      "test.type" : "test",
      "_dd.tracer_host" : ${content_meta__dd_tracer_host},
      "test.status" : "fail",
      "test.early_flake.enabled" : "true",
      "test_session.name" : "session-name",
      "language" : "jvm",
      "env" : "none",
      "dummy_ci_tag" : "dummy_ci_tag_value",
      "library_version" : ${content_meta_library_version},
      "component" : "junit",
      "_dd.profiling.ctx" : "test",
      "span.kind" : "test_session_end",
      "runtime-id" : ${content_meta_runtime_id},
      "test.command" : "junit-4.10",
      "test.framework_version" : ${content_meta_test_framework_version},
      "test.framework" : "junit4"
    }
  }
}, {
  "type" : "test_module_end",
  "version" : 1,
  "content" : {
    "test_session_id" : ${content_test_session_id},
    "test_module_id" : ${content_test_module_id},
    "service" : "worker.org.gradle.process.internal.worker.gradleworkermain",
    "name" : "junit.test_module",
    "resource" : "junit-4.10",
    "start" : ${content_start_2},
    "duration" : ${content_duration_2},
    "error" : 0,
    "metrics" : { },
    "meta" : {
      "test.type" : "test",
      "test.module" : "junit-4.10",
      "test.status" : "fail",
      "test.early_flake.enabled" : "true",
      "test_session.name" : "session-name",
      "env" : "none",
      "dummy_ci_tag" : "dummy_ci_tag_value",
      "library_version" : ${content_meta_library_version},
      "component" : "junit",
      "span.kind" : "test_module_end",
      "test.framework_version" : ${content_meta_test_framework_version},
      "test.framework" : "junit4"
    }
  }
}, {
  "type" : "test_suite_end",
  "version" : 1,
  "content" : {
    "test_session_id" : ${content_test_session_id},
    "test_module_id" : ${content_test_module_id},
    "test_suite_id" : ${content_test_suite_id},
    "service" : "worker.org.gradle.process.internal.worker.gradleworkermain",
    "name" : "junit.test_suite",
    "resource" : "org.example.TestFailedAndSucceed",
    "start" : ${content_start_3},
    "duration" : ${content_duration_3},
    "error" : 0,
    "metrics" : { },
    "meta" : {
      "test.type" : "test",
      "test.source.file" : "dummy_source_path",
      "test.module" : "junit-4.10",
      "test.status" : "fail",
      "test_session.name" : "session-name",
      "env" : "none",
      "dummy_ci_tag" : "dummy_ci_tag_value",
      "library_version" : ${content_meta_library_version},
      "component" : "junit",
      "span.kind" : "test_suite_end",
      "test.suite" : "org.example.TestFailedAndSucceed",
      "test.framework_version" : ${content_meta_test_framework_version},
      "test.framework" : "junit4"
    }
  }
}, {
  "type" : "test",
  "version" : 2,
  "content" : {
    "trace_id" : ${content_trace_id},
    "span_id" : ${content_span_id},
    "parent_id" : ${content_parent_id},
    "test_session_id" : ${content_test_session_id},
    "test_module_id" : ${content_test_module_id},
    "test_suite_id" : ${content_test_suite_id},
    "service" : "worker.org.gradle.process.internal.worker.gradleworkermain",
    "name" : "junit.test",
    "resource" : "org.example.TestFailedAndSucceed.test_another_succeed",
    "start" : ${content_start_4},
    "duration" : ${content_duration_4},
    "error" : 0,
    "metrics" : {
      "process_id" : ${content_metrics_process_id},
      "_dd.profiling.enabled" : 0,
      "_dd.trace_span_attribute_schema" : 0,
      "test.source.end" : 18,
      "test.source.start" : 12
    },
    "meta" : {
      "_dd.tracer_host" : ${content_meta__dd_tracer_host},
      "test.source.file" : "dummy_source_path",
      "test.source.method" : "test_another_succeed()V",
      "test.module" : "junit-4.10",
      "test.status" : "pass",
      "language" : "jvm",
      "test.is_new" : "true",
      "test.codeowners" : "[\"owner1\",\"owner2\"]",
      "library_version" : ${content_meta_library_version},
      "test.name" : "test_another_succeed",
      "span.kind" : "test",
      "test.suite" : "org.example.TestFailedAndSucceed",
      "runtime-id" : ${content_meta_runtime_id},
      "test.type" : "test",
      "test_session.name" : "session-name",
      "env" : "none",
      "dummy_ci_tag" : "dummy_ci_tag_value",
      "component" : "junit",
      "_dd.profiling.ctx" : "test",
      "test.framework_version" : ${content_meta_test_framework_version},
      "test.framework" : "junit4"
    }
  }
}, {
  "type" : "test",
  "version" : 2,
  "content" : {
    "trace_id" : ${content_trace_id_2},
    "span_id" : ${content_span_id_2},
    "parent_id" : ${content_parent_id},
    "test_session_id" : ${content_test_session_id},
    "test_module_id" : ${content_test_module_id},
    "test_suite_id" : ${content_test_suite_id},
    "service" : "worker.org.gradle.process.internal.worker.gradleworkermain",
    "name" : "junit.test",
    "resource" : "org.example.TestFailedAndSucceed.test_another_succeed",
    "start" : ${content_start_5},
    "duration" : ${content_duration_5},
    "error" : 0,
    "metrics" : {
      "process_id" : ${content_metrics_process_id},
      "_dd.profiling.enabled" : 0,
      "_dd.trace_span_attribute_schema" : 0,
      "test.source.end" : 18,
      "test.source.start" : 12
    },
    "meta" : {
      "_dd.tracer_host" : ${content_meta__dd_tracer_host},
      "test.source.file" : "dummy_source_path",
      "test.source.method" : "test_another_succeed()V",
      "test.module" : "junit-4.10",
      "test.status" : "pass",
      "language" : "jvm",
      "test.is_new" : "true",
      "test.codeowners" : "[\"owner1\",\"owner2\"]",
      "library_version" : ${content_meta_library_version},
      "test.name" : "test_another_succeed",
      "span.kind" : "test",
      "test.suite" : "org.example.TestFailedAndSucceed",
      "runtime-id" : ${content_meta_runtime_id},
      "test.type" : "test",
      "test_session.name" : "session-name",
      "env" : "none",
      "dummy_ci_tag" : "dummy_ci_tag_value",
      "test.is_retry" : "true",
      "component" : "junit",
      "_dd.profiling.ctx" : "test",
      "test.framework_version" : ${content_meta_test_framework_version},
      "test.framework" : "junit4"
    }
  }
}, {
  "type" : "test",
  "version" : 2,
  "content" : {
    "trace_id" : ${content_trace_id_3},
    "span_id" : ${content_span_id_3},
    "parent_id" : ${content_parent_id},
    "test_session_id" : ${content_test_session_id},
    "test_module_id" : ${content_test_module_id},
    "test_suite_id" : ${content_test_suite_id},
    "service" : "worker.org.gradle.process.internal.worker.gradleworkermain",
    "name" : "junit.test",
    "resource" : "org.example.TestFailedAndSucceed.test_another_succeed",
    "start" : ${content_start_6},
    "duration" : ${content_duration_6},
    "error" : 0,
    "metrics" : {
      "process_id" : ${content_metrics_process_id},
      "_dd.profiling.enabled" : 0,
      "_dd.trace_span_attribute_schema" : 0,
      "test.source.end" : 18,
      "test.source.start" : 12
    },
    "meta" : {
      "_dd.tracer_host" : ${content_meta__dd_tracer_host},
      "test.source.file" : "dummy_source_path",
      "test.source.method" : "test_another_succeed()V",
      "test.module" : "junit-4.10",
      "test.status" : "pass",
      "language" : "jvm",
      "test.is_new" : "true",
      "test.codeowners" : "[\"owner1\",\"owner2\"]",
      "library_version" : ${content_meta_library_version},
      "test.name" : "test_another_succeed",
      "span.kind" : "test",
      "test.suite" : "org.example.TestFailedAndSucceed",
      "runtime-id" : ${content_meta_runtime_id},
      "test.type" : "test",
      "test_session.name" : "session-name",
      "env" : "none",
      "dummy_ci_tag" : "dummy_ci_tag_value",
      "test.is_retry" : "true",
      "component" : "junit",
      "_dd.profiling.ctx" : "test",
      "test.framework_version" : ${content_meta_test_framework_version},
      "test.framework" : "junit4"
    }
  }
}, {
  "type" : "test",
  "version" : 2,
  "content" : {
    "trace_id" : ${content_trace_id_4},
    "span_id" : ${content_span_id_4},
    "parent_id" : ${content_parent_id},
    "test_session_id" : ${content_test_session_id},
    "test_module_id" : ${content_test_module_id},
    "test_suite_id" : ${content_test_suite_id},
    "service" : "worker.org.gradle.process.internal.worker.gradleworkermain",
    "name" : "junit.test",
    "resource" : "org.example.TestFailedAndSucceed.test_failed",
    "start" : ${content_start_7},
    "duration" : ${content_duration_7},
    "error" : 1,
    "metrics" : {
      "process_id" : ${content_metrics_process_id},
      "_dd.profiling.enabled" : 0,
      "_dd.trace_span_attribute_schema" : 0,
      "test.source.end" : 18,
      "test.source.start" : 12
    },
    "meta" : {
      "_dd.tracer_host" : ${content_meta__dd_tracer_host},
      "test.source.file" : "dummy_source_path",
      "test.source.method" : "test_failed()V",
      "test.module" : "junit-4.10",
      "test.status" : "fail",
      "language" : "jvm",
      "test.codeowners" : "[\"owner1\",\"owner2\"]",
      "library_version" : ${content_meta_library_version},
      "test.name" : "test_failed",
      "span.kind" : "test",
      "test.suite" : "org.example.TestFailedAndSucceed",
      "runtime-id" : ${content_meta_runtime_id},
      "test.type" : "test",
      "test_session.name" : "session-name",
      "env" : "none",
      "dummy_ci_tag" : "dummy_ci_tag_value",
      "component" : "junit",
      "error.type" : "java.lang.AssertionError",
      "_dd.profiling.ctx" : "test",
      "error.stack" : ${content_meta_error_stack},
      "test.framework_version" : ${content_meta_test_framework_version},
      "test.framework" : "junit4"
    }
  }
}, {
  "type" : "test",
  "version" : 2,
  "content" : {
    "trace_id" : ${content_trace_id_5},
    "span_id" : ${content_span_id_5},
    "parent_id" : ${content_parent_id},
    "test_session_id" : ${content_test_session_id},
    "test_module_id" : ${content_test_module_id},
    "test_suite_id" : ${content_test_suite_id},
    "service" : "worker.org.gradle.process.internal.worker.gradleworkermain",
    "name" : "junit.test",
    "resource" : "org.example.TestFailedAndSucceed.test_succeed",
    "start" : ${content_start_8},
    "duration" : ${content_duration_8},
    "error" : 0,
    "metrics" : {
      "process_id" : ${content_metrics_process_id},
      "_dd.profiling.enabled" : 0,
      "_dd.trace_span_attribute_schema" : 0,
      "test.source.end" : 18,
      "test.source.start" : 12
    },
    "meta" : {
      "_dd.tracer_host" : ${content_meta__dd_tracer_host},
      "test.source.file" : "dummy_source_path",
      "test.source.method" : "test_succeed()V",
      "test.module" : "junit-4.10",
      "test.status" : "pass",
      "language" : "jvm",
      "test.codeowners" : "[\"owner1\",\"owner2\"]",
      "library_version" : ${content_meta_library_version},
      "test.name" : "test_succeed",
      "span.kind" : "test",
      "test.suite" : "org.example.TestFailedAndSucceed",
      "runtime-id" : ${content_meta_runtime_id},
      "test.type" : "test",
      "test_session.name" : "session-name",
      "env" : "none",
      "dummy_ci_tag" : "dummy_ci_tag_value",
      "component" : "junit",
      "_dd.profiling.ctx" : "test",
      "test.framework_version" : ${content_meta_test_framework_version},
      "test.framework" : "junit4"
    }
  }
} ]