require 'capybara'
require 'capybara/dsl'
require 'capybara/sessionkeeper'

module Automation
  class Base
    include Capybara::DSL

    def human_delay
      sleep(rand(1.0..3.0))
    end

    def session
      Capybara::Session.new(:selenium_chrome)
    end
  end
end

# Automation::Captain.new.rise