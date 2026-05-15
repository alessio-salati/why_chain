# frozen_string_literal: true

RSpec.describe "WhyChain.explain formatting options" do
  it "supports compact style output" do
    auditable = Module.new { define_method(:save) { super() } }
    base = Class.new { define_method(:save) { :ok } }
    klass = Class.new(base) { prepend auditable }

    explanation = WhyChain.explain(klass.new, :save, style: :compact)

    expect(explanation).to include("WhyChain :save")
    expect(explanation).to include("1) [prepend] #{auditable}#save")
    expect(explanation).to include("-> super")
    expect(explanation).to include("2) [class] #{base}#save")
  end

  it "supports teaching style output" do
    explanation = WhyChain.explain(String.new("abc"), :upcase, style: :teaching)

    expect(explanation).to include("Ruby dispatch explanation for :upcase")
    expect(explanation).to include("1. String#upcase")
  end

  it "returns non-colored output when color is disabled" do
    explanation = WhyChain.explain(String.new("abc"), :upcase, color: false)

    expect(explanation).not_to match(/\e\[/)
  end
end
