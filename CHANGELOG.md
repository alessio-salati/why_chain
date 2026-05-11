## [Unreleased]

## [0.2.1] - 2026-05-11

- Refactor internals by extracting shared method-definition predicate into `MethodDefinition`.
- Remove duplicated visibility checks from `Tracer` and `MethodLocator` without behavior changes.

## [0.2.0] - 2026-05-11

- Add `WhyChain.explain(object, method_name)` for human-readable dispatch output.
- Extend `DispatchTrace` with `source_location` and ordered `steps` data.
- Introduce `DispatchStep` value object for typed dispatch step representation.
- Add focused specs for explain output and super-path step tracing.

## [0.1.0] - 2026-05-10

- Initial release
