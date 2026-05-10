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
        next_super_owner: next_super_owner
      )
    end

    private

    def lookup_chain
      @object.singleton_class.ancestors
    end

    def owner
      @owner ||= @object.method(@method_name).owner
    end

    def next_super_owner
      MethodLocator.new(lookup_chain, owner, @method_name).next_super_owner
    end
  end
end
