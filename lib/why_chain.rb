# frozen_string_literal: true

require_relative "why_chain/version"
require_relative "why_chain/tracer"
require_relative "why_chain/dispatch_trace"
require_relative "why_chain/method_locator"

# Entry point for WhyChain runtime dispatch introspection.
module WhyChain
  class Error < StandardError; end

  def self.trace(object, method_name)
    Tracer.new(object, method_name).trace
  end
end
