# frozen_string_literal: true

module WhyChain
  # Formats a human-friendly runtime dispatch explanation.
  class Explainer
    def initialize(trace, method_name)
      @trace = trace
      @method_name = method_name
    end

    def to_s
      lines = ["Ruby dispatch explanation for :#{@method_name}", ""]

      explanation_steps.each_with_index do |step, index|
        lines.concat(step_lines(step, index))
      end

      lines.join("\n")
    end

    private

    def explanation_steps
      return @trace.steps unless @trace.steps.empty?

      [DispatchStep.new(owner: @trace.owner, source_location: @trace.source_location)]
    end

    def format_source_location(source_location)
      source_location ? source_location.join(":") : "<native>"
    end

    def step_lines(step, index)
      lines = [
        "#{index + 1}. #{step.owner}##{@method_name}",
        "   defined at:",
        "   #{format_source_location(step.source_location)}"
      ]

      return lines unless index < explanation_steps.length - 1

      lines + ["", "   calls super ->", ""]
    end
  end
end
