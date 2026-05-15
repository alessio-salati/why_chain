# frozen_string_literal: true

module WhyChain
  class Explainer
    # Compact debug-friendly explanation format.
    class CompactFormatter
      def initialize(method_name, steps, graph, colorizer)
        @method_name = method_name
        @steps = steps
        @graph = graph
        @colorizer = colorizer
      end

      def render
        lines = [@colorizer.colorize("WhyChain :#{@method_name}", :title)]

        @steps.each_with_index do |step, index|
          lines << step_line(step, index)
          lines << @colorizer.colorize("   -> super", :arrow) if @graph && index < @steps.length - 1
        end

        lines.join("\n")
      end

      private

      def step_line(step, index)
        kind = @colorizer.colorize("[#{step.kind || :unknown}]", :kind)
        label = @colorizer.colorize("#{index + 1}) #{kind} #{step.owner}##{@method_name}", :owner)
        location = @colorizer.format_source_location(step.source_location, color: false)
        "#{label}  #{@colorizer.colorize(location, :location)}"
      end
    end
  end
end
