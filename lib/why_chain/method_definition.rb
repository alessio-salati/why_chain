# frozen_string_literal: true

module WhyChain
  # Shared predicate for direct method definitions in a lookup node.
  module MethodDefinition
    module_function

    def defined_directly?(mod, method_name)
      mod.method_defined?(method_name, false) ||
        mod.private_method_defined?(method_name, false) ||
        mod.protected_method_defined?(method_name, false)
    end
  end
end
