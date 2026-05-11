# frozen_string_literal: true

RSpec.describe "WhyChain.explain" do
  it "renders a multi-step dispatch explanation with source locations" do
    auditable = Module.new { define_method(:save) { super() } }
    base = Class.new { define_method(:save) { :ok } }
    klass = Class.new(base) { prepend auditable }

    explanation = WhyChain.explain(klass.new, :save)

    first_location = auditable.instance_method(:save).source_location.join(":")
    second_location = base.instance_method(:save).source_location.join(":")

    expect(explanation).to include("Ruby dispatch explanation for :save")
    expect(explanation).to include("1. #{auditable}#save")
    expect(explanation).to include("defined at:\n   #{first_location}")
    expect(explanation).to include("calls super ->")
    expect(explanation).to include("2. #{base}#save")
    expect(explanation).to include("defined at:\n   #{second_location}")
  end

  it "shows native when source location is unavailable" do
    explanation = WhyChain.explain(String.new("abc"), :upcase)

    expect(explanation).to include("defined at:\n   <native>")
  end
end
