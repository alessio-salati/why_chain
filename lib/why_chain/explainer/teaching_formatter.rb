# frozen_string_literal: true

module WhyChain
  class Explainer
    # Verbose didactic explanation format.
    class TeachingFormatter
      def initialize(method_name, steps, graph, colorizer)
        @method_name = method_name
        @steps = steps
        @graph = graph
        @colorizer = colorizer
      end

      def render
        lines = [@colorizer.colorize("Ruby dispatch explanation for :#{@method_name}", :title), ""]

        @steps.each_with_index do |step, index|
          lines.concat(step_lines(step, index))
        end

        lines.join("\n")
      end

      private

      def step_lines(step, index)
        lines = [
          @colorizer.colorize("#{index + 1}. #{step.owner}##{@method_name}", :owner),
          @colorizer.colorize("   defined at:", :label),
          "   #{@colorizer.format_source_location(step.source_location)}"
        ]

        return lines unless @graph && index < @steps.length - 1

        lines + ["", @colorizer.colorize("   calls super ->", :arrow), ""]
      end
    end
  end
end
