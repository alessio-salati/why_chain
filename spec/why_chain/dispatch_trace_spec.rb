# frozen_string_literal: true

RSpec.describe WhyChain::DispatchTrace do
  let(:trace) do
    described_class.new(
      lookup_chain: [String, Comparable],
      owner: String,
      next_super_owner: Comparable,
      source_location: ["trace.rb", 12],
      steps: [{ owner: String, source_location: ["trace.rb", 12] }, { owner: Comparable, source_location: nil }]
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
          steps: [{ owner: String, source_location: ["trace.rb", 12] }, { owner: Comparable, source_location: nil }]
        }
      )
    end
  end
end
