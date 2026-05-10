# frozen_string_literal: true

module WhyChain
  # Immutable value object for traced dispatch data.
  class DispatchTrace
    attr_reader :lookup_chain, :owner, :next_super_owner

    def initialize(
      lookup_chain:,
      owner:,
      next_super_owner:
    )
      @lookup_chain = lookup_chain
      @owner = owner
      @next_super_owner = next_super_owner
    end

    def to_h
      {
        lookup_chain: lookup_chain,
        owner: owner,
        next_super_owner: next_super_owner
      }
    end
  end
end
