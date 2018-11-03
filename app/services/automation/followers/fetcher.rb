module Automation
  module Followers
    class Fetcher < Base
      def initialize
        restore_session
      end

      def run(profile_name = 'e36.only')
        visit "https://www.instagram.com/#{profile_name}"
        page.find(:xpath, "//a[contains(@href, 'followers') and not(contains(@href, 'mutualOnly'))]").click

        fetch_follower_links
      end

      private

      def fetch_follower_links
        page.find_all(:xpath, "//a[contains(@class, 'FPmhX')]").map do |follower|
          follower[:href]
        end
      end

      def scroll_followers_modal
        within page.find(:xpath, "//*[@role='dialog']") do
          #scroll
        end
      end
    end
  end
end
