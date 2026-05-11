# frozen_string_literal: true

module WhyChain
  # Immutable value object for a single dispatch step.
  class DispatchStep
    attr_reader :owner, :source_location

    def initialize(owner:, source_location:)
      @owner = owner
      @source_location = source_location
    end

    def to_h
      {
        owner: owner,
        source_location: source_location
      }
    end
  end
end
