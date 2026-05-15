# frozen_string_literal: true

STEP_VALUES = [
  { owner: String, source_location: ["trace.rb", 12], kind: :class },
  { owner: Comparable, source_location: nil, kind: :include }
].freeze

RSpec.describe WhyChain::DispatchTrace do
  let(:trace) do
    described_class.new(
      lookup_chain: [String, Comparable],
      owner: String,
      next_super_owner: Comparable,
      source_location: ["trace.rb", 12],
      steps: STEP_VALUES
    )
  end

  describe "#to_h" do
    it "returns a hash representation of the trace" do
      expect(trace.to_h).to eq(
        {
          lookup_chain: [String, Comparable],
          owner: String,
          next_super_owner: Comparable,
          source_location: ["trace.rb", 12],
          steps: STEP_VALUES
        }
      )
    end
  end
end
