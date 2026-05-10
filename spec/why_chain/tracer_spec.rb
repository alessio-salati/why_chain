# frozen_string_literal: true

RSpec.describe WhyChain::Tracer do
  describe "#trace" do
    it "returns a DispatchTrace value object" do
      klass = Class.new do
        def ping; end
      end

      trace = described_class.new(klass.new, :ping).trace

      expect(trace).to be_a(WhyChain::DispatchTrace)
      expect(trace.owner).to eq(klass)
    end
  end
end
