# frozen_string_literal: true

RSpec.describe WhyChain do
  include_context "dispatch chain with prepend and include"

  it "has a version number" do
    expect(WhyChain::VERSION).not_to be nil
  end

  it "finds owner and next super owner in lookup order" do
    trace = WhyChain.trace(class_b.new, :foo)
    expect(trace).to be_a(WhyChain::DispatchTrace)
    expect(trace.owner).to eq(mod_p)
    expect(trace.next_super_owner).to eq(mod_i)
  end

  it "raises NameError when method is missing" do
    expect { WhyChain.trace(Object.new, :not_existing_method) }.to raise_error(NameError)
  end

  it "starts lookup chain from singleton class" do
    obj = Object.new
    def obj.singleton_foo = :singleton

    trace = WhyChain.trace(obj, :singleton_foo)

    expect(trace.lookup_chain.first).to eq(obj.singleton_class)
    expect(trace.owner).to eq(obj.singleton_class)
  end
end
