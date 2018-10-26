module Automation
  class Captain < Base
    def rise
      session.visit 'https://www.instagram.com/accounts/login/?source=auth_switcher'

      binding.pry
      # Automation::Login.new
      # human_delay

      # Automation::Like.new
    end
  end
end
