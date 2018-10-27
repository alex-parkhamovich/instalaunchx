module Automation
  class Captain < Base
    def rise
      restore_session

      visit 'https://www.instagram.com/accounts/login/?source=auth_switcher'
      human_delay

      Automation::Like.new

      true
    end
  end
end
