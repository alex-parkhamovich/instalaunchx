require 'capybara'
require 'capybara/dsl'
require 'capybara/sessionkeeper'

module Bot
  class Base
    include Capybara::DSL

    Capybara.register_driver :mobile_chrome do |app|
      Capybara::Selenium::Driver.new(app,
        browser: :chrome,
        desired_capabilities:
          Selenium::WebDriver::Remote::Capabilities.chrome(
            'chromeOptions' => {
              'mobileEmulation' => {
                'deviceMetrics' => {
                  'width' => 360, 'height' => 640, 'pixelRatio' => 3.0
                },
                'userAgent' =>
                  "Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 " \
                  "Build/JOP40D) AppleWebKit/535.19 (KHTML, like Gecko) " \
                  "Chrome/18.0.1025.166 Mobile Safari/535.19"
              }
            }
          )
      )
    end

    if Rails.env.development?
      Capybara.default_driver = :mobile_chrome
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
      @current_promotion ||= Promotion.new(
        account_id: 1,
        profile_names: 'e36.only'
      )
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
