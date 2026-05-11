# frozen_string_literal: true

require_relative "why_chain/version"
require_relative "why_chain/tracer"
require_relative "why_chain/dispatch_trace"
require_relative "why_chain/dispatch_step"
require_relative "why_chain/method_locator"
require_relative "why_chain/explainer"

# Entry point for WhyChain runtime dispatch introspection.
module WhyChain
  class Error < StandardError; end

  def self.trace(object, method_name)
    Tracer.new(object, method_name).trace
  end

  def self.explain(object, method_name)
    Explainer.new(trace(object, method_name), method_name).to_s
  end
end
