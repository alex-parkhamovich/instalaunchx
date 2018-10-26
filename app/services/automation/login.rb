module Automation
  class Login < Base
    def initialize
      session.visit login_url
      human_delay

      # TODO: create autologin
      binding.pry
      human_delay

      # notifications_popup_btn.click
    end

    private

    def login_url
      'https://www.instagram.com/accounts/login/?source=auth_switcher'
    end

    def notifications_popup_btn
      session.page.find(:button, 'Not Now')
    end
  end
end
