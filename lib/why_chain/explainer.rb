# frozen_string_literal: true

require_relative "explainer/colorizer"
require_relative "explainer/teaching_formatter"
require_relative "explainer/compact_formatter"

module WhyChain
  # Formats a human-friendly runtime dispatch explanation.
  class Explainer
    def initialize(trace, method_name, style: :teaching, color: :auto, graph: true)
      @trace = trace
      @method_name = method_name
      @style = style
      @graph = graph
      @colorizer = Colorizer.new(color)
    end

    def to_s
      case @style
      when :teaching
        TeachingFormatter.new(@method_name, explanation_steps, @graph, @colorizer).render
      when :compact
        CompactFormatter.new(@method_name, explanation_steps, @graph, @colorizer).render
      else
        raise ArgumentError, "Unknown style: #{@style.inspect}"
      end
    end

    private

    def explanation_steps
      return @trace.steps unless @trace.steps.empty?

      [DispatchStep.new(owner: @trace.owner, source_location: @trace.source_location)]
    end
  end
end
