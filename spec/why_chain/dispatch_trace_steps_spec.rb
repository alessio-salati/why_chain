# frozen_string_literal: true

RSpec.describe WhyChain::DispatchTrace, "steps" do
  it "exposes dispatch steps as value objects" do
    trace = described_class.new(
      lookup_chain: [String, Comparable],
      owner: String,
      next_super_owner: Comparable,
      steps: [{ owner: String, source_location: ["trace.rb", 12], kind: :class }]
    )

    expect(trace.steps.first).to be_a(WhyChain::DispatchStep)
    expect(trace.steps.first.owner).to eq(String)
    expect(trace.steps.first.kind).to eq(:class)
  end
end
