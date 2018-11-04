require 'capybara'
require 'capybara/dsl'
require 'capybara/sessionkeeper'

module Automation
  class Base
    include Capybara::DSL

    Capybara.default_driver = :selenium_chrome

    def around_like_delay
      sleep(rand(15.0..20.0))
    end

    def current_account
      Account.first
    end

    def human_delay
      sleep(rand(1.0..3.0))
    end

    def restore_session
      visit 'https://www.instagram.com/accounts/login/?source=auth_switcher'
      Capybara.current_session.restore_cookies("/Users/Alex/Documents/Projects/instalaunchx/capybara-201810270922091638778457.cookies.txt")
    end

    def save_session
      Capybara.current_session.save_cookies
    end
  end
end
