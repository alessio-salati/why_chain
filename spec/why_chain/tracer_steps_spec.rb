# frozen_string_literal: true

RSpec.describe WhyChain::Tracer, "#trace with super chain" do
  it "captures source location and dispatch steps in super order" do
    auditable = Module.new { define_method(:save) { super() } }
    base = Class.new { define_method(:save) { :ok } }
    klass = Class.new(base) { prepend auditable }

    trace = described_class.new(klass.new, :save).trace

    expect(trace.source_location).to eq(auditable.instance_method(:save).source_location)
    expect(trace.steps.map(&:owner)).to eq([auditable, base])
    expect(trace.steps.map(&:kind)).to eq(%i[prepend class])
    expect(trace.steps.first.source_location).to eq(auditable.instance_method(:save).source_location)
    expect(trace.steps.last.source_location).to eq(base.instance_method(:save).source_location)
  end
end
