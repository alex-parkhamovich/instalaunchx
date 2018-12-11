require 'capybara'
require 'capybara/dsl'
require 'capybara/sessionkeeper'

module Bot
  class Base
    include Capybara::DSL

    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
            'chromeOptions' => {
              'binary' => "#{ENV['GOOGLE_CHROME_SHIM']}",
              'mobileEmulation' => { "deviceName" => "Nexus 5" }
            }
          )

    Capybara.register_driver :mobile_chrome do |app|
      Capybara::Selenium::Driver.new(app,
        browser: :chrome,
        desired_capabilities: caps
      )
    end

    Capybara.default_driver = :mobile_chrome

    def todays_likes_limit_reached?
      current_account.likes_today > 900
    end

    def around_like_delay
      sleep(rand(15.0..20.0))
    end

    def current_account
      Account.last
    end

    def current_promotion
      Promotion.last
    end

    def current_followers_pack
      current_promotion.followers_packs.last
    end

    def human_delay
      sleep(rand(1.0..3.0))
    end

    def restore_session
      visit 'https://www.instagram.com/accounts/login/?source=auth_switcher'
      Capybara.current_session.restore_cookies(File.join(Rails.root, 'lib/assets/cookies/alex_parkhamovich.cookies.txt'))
    end

    def save_session
      Capybara.current_session.save_cookies
    end
  end
end
