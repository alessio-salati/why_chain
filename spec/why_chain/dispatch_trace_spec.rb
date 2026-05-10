# frozen_string_literal: true

RSpec.describe WhyChain::DispatchTrace do
  describe "#to_h" do
    it "returns a hash representation of the trace" do
      trace = described_class.new(
        lookup_chain: [String, Comparable],
        owner: String,
        next_super_owner: Comparable
      )

      expect(trace.to_h).to eq(
        {
          lookup_chain: [String, Comparable],
          owner: String,
          next_super_owner: Comparable
        }
      )
    end
  end
end
