# frozen_string_literal: true

module WhyChain
  # Builds a dispatch trace for a receiver and method.
  class Tracer
    def initialize(object, method_name)
      @object = object
      @method_name = method_name
    end

    def trace
      DispatchTrace.new(
        lookup_chain: lookup_chain,
        owner: owner,
        next_super_owner: next_super_owner,
        source_location: method_object.source_location,
        steps: steps
      )
    end

    private

    def lookup_chain
      @object.singleton_class.ancestors
    end

    def owner
      @owner ||= method_object.owner
    end

    def method_object
      @method_object ||= @object.method(@method_name)
    end

    def next_super_owner
      MethodLocator.new(lookup_chain, owner, @method_name).next_super_owner
    end

    def steps
      lookup_chain.filter_map do |mod|
        next unless MethodDefinition.defined_directly?(mod, @method_name)

        DispatchStep.new(
          owner: mod,
          source_location: mod.instance_method(@method_name).source_location
        )
      end
    end
  end
end
