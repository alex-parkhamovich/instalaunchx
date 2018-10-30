module Automation
  module Followers
    class Fetcher < Base
      def initialize(profile_name = 'e36.only')
        restore_session

        visit "https://www.instagram.com/#{profile_name}"
        page.find(:xpath, "//a[contains(@href, 'followers')]").click

        fetch_follower_names
      end

      private

      def fetch_follower_names
        followers = []
        page.find_all(:xpath, "//a[contains(@class, 'FPmhX')]").each do |follower|
           followers << follower.text
        end
        followers
      end

      def scroll_followers_modal
        within page.find(:xpath, "//*[@role='dialog']") do
          #scroll
        end
      end
    end
  end
end
