require 'capybara/axe/configuration'

module Capybara
  module Axe
    class << self
      attr_accessor :configuration
    end

    def self.configure(&block)
      self.configuration ||= Configuration.new
      block.call(self.configuration)
    end
  end
end
