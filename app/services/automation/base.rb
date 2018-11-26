require 'capybara'
require 'capybara/dsl'
require 'capybara/sessionkeeper'

module Automation
  class Base
    include Capybara::DSL

    DEFAULT_WINDOW_SIZE = {
      width: 1280,
      height: 800
    }

    MOBILE_WINDOW_SIZE = {
      width: 375,
      height: 800
    }

    if Rails.env.development?
      Capybara.default_driver = :selenium_chrome_headless
    else
      Capybara.default_driver = :selenium_chrome_headless
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

    def resize_window(type = nil)
      if type == 'mobile'
        page.driver.browser.manage.window.resize_to(
          MOBILE_WINDOW_SIZE[:width],
          MOBILE_WINDOW_SIZE[:height]
        )
      else
        page.driver.browser.manage.window.resize_to(
          DEFAULT_WINDOW_SIZE[:width],
          DEFAULT_WINDOW_SIZE[:height]
        )
      end
      page.driver.refresh
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
