# frozen_string_literal: true

module WhyChain
  # Immutable value object for traced dispatch data.
  class DispatchTrace
    attr_reader :lookup_chain, :owner, :next_super_owner, :source_location, :steps

    def initialize(
      lookup_chain:,
      owner:,
      next_super_owner:,
      source_location: nil,
      steps: []
    )
      @lookup_chain = lookup_chain
      @owner = owner
      @next_super_owner = next_super_owner
      @source_location = source_location
      @steps = steps.map { |step| coerce_step(step) }
    end

    def to_h
      {
        lookup_chain: lookup_chain,
        owner: owner,
        next_super_owner: next_super_owner,
        source_location: source_location,
        steps: steps.map(&:to_h)
      }
    end

    private

    def coerce_step(step)
      return step if step.is_a?(DispatchStep)

      DispatchStep.new(**step)
    end
  end
end
