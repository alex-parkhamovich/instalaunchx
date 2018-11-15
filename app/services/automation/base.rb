require 'capybara'
require 'capybara/dsl'
require 'capybara/sessionkeeper'

module Automation
  class Base
    include Capybara::DSL

    if Rails.env.development?
      Capybara.default_driver = :selenium_chrome
    else
      Capybara.default_driver = :selenium_headless_chrome
    end

    def around_like_delay
      sleep(rand(15.0..20.0))
    end

    def current_account
      Account.first
    end

    def current_promotion
      Promotion.last
    end

    def human_delay
      sleep(rand(1.0..3.0))
    end

    def restore_session
      visit 'https://www.instagram.com/accounts/login/?source=auth_switcher'
      Capybara.current_session.restore_cookies("/Users/Alex/Documents/Projects/instalaunchx/public/cookies/alex_parkhamovich.cookies.txt")
    end

    def save_session
      Capybara.current_session.save_cookies
    end
  end
end
