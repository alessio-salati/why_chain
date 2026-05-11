# frozen_string_literal: true

module WhyChain
  # Finds where super resolves after a method owner.
  class MethodLocator
    def initialize(lookup_chain, owner, method_name)
      @lookup_chain = lookup_chain
      @owner = owner
      @method_name = method_name
    end

    def next_super_owner
      owner_index = @lookup_chain.index(@owner)

      return nil unless owner_index

      @lookup_chain[(owner_index + 1)..].find do |mod|
        MethodDefinition.defined_directly?(mod, @method_name)
      end
    end
  end
end
