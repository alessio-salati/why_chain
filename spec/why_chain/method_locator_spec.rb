# frozen_string_literal: true

RSpec.describe WhyChain::MethodLocator do
  describe "#next_super_owner" do
    it "returns nil when owner is not in lookup chain" do
      lookup_chain = [String, Comparable]
      locator = described_class.new(lookup_chain, Array, :size)

      expect(locator.next_super_owner).to be_nil
    end

    { secret: :private, guarded: :protected }.each do |method_name, visibility|
      it "finds next owner for a #{visibility} method" do
        base = Class.new do
          send(visibility)
          define_method(method_name) { :implemented }
        end
        child = Class.new(base)
        owner = Class.new(child)
        lookup_chain = [owner, child, base]

        locator = described_class.new(lookup_chain, owner, method_name)

        expect(locator.next_super_owner).to eq(base)
      end
    end
  end
end
