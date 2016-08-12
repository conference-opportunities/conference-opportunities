module Capybara
  module Axe
    class Configuration
      attr_accessor :skip_paths, :skip_rules

      def initialize
        @skip_paths = []
        @skip_rules = []
      end

      def rules
        [:wcag2a, :wcag2aa, :section508, :'best-practice'] - skip_rules
      end

      def skip?(path)
        skip_paths.any? do |skip|
          if skip.is_a?(Regexp)
            skip =~ path
          else
            skip == path
          end
        end
      end
    end
  end
end
