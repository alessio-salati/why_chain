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
      receiver_class = @object.is_a?(Module) ? @object : @object.class
      receiver_class_index = lookup_chain.index(receiver_class)

      lookup_chain.filter_map do |mod|
        next unless MethodDefinition.defined_directly?(mod, @method_name)

        DispatchStep.new(
          owner: mod,
          source_location: mod.instance_method(@method_name).source_location,
          kind: step_kind_for(mod, receiver_class_index)
        )
      end
    end

    def step_kind_for(mod, receiver_class_index)
      return :singleton if mod == @object.singleton_class
      return :class if mod.is_a?(Class)

      return :include unless receiver_class_index

      lookup_chain.index(mod) < receiver_class_index ? :prepend : :include
    end
  end
end
