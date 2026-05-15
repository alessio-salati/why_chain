# frozen_string_literal: true

module WhyChain
  class Explainer
    # Handles ANSI color output and source location formatting.
    class Colorizer
      ANSI_CODES = {
        title: "1;36",
        owner: "32",
        kind: "35",
        label: "2;37",
        location: "2;37",
        native: "33",
        arrow: "36"
      }.freeze

      def initialize(color_mode)
        @use_color = resolve_color(color_mode)
      end

      def colorize(text, tone)
        return text unless @use_color

        code = ANSI_CODES.fetch(tone, "0")
        "\e[#{code}m#{text}\e[0m"
      end

      def format_source_location(source_location, color: true)
        formatted = source_location ? source_location.join(":") : "<native>"
        return formatted unless color

        source_location ? colorize(formatted, :location) : colorize(formatted, :native)
      end

      private

      def resolve_color(color)
        case color
        when true
          true
        when false
          false
        when :auto
          $stdout.tty? && ENV["CI"] != "true"
        else
          raise ArgumentError, "Unknown color mode: #{color.inspect}"
        end
      end
    end
  end
end
