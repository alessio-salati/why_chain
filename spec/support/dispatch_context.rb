# frozen_string_literal: true

RSpec.shared_context "dispatch chain with prepend and include" do
  let(:mod_p) do
    Module.new do
      def foo = :p
    end
  end

  let(:mod_i) do
    Module.new do
      def foo = :i
    end
  end

  let(:class_a) do
    Class.new do
      def foo = :a
    end
  end

  let(:class_b) do
    p = mod_p
    i = mod_i

    Class.new(class_a) do
      include i
      prepend p
    end
  end
end
