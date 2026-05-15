# frozen_string_literal: true

module WhyChain
  # Immutable value object for a single dispatch step.
  class DispatchStep
    attr_reader :owner, :source_location, :kind

    def initialize(owner:, source_location:, kind: nil)
      @owner = owner
      @source_location = source_location
      @kind = kind
    end

    def to_h
      {
        owner: owner,
        source_location: source_location,
        kind: kind
      }
    end
  end
end
