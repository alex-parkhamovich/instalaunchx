module Automation
  module Followers
    class Fetcher < Base
      def initialize
        restore_session
      end

      def run
        last_promotion_profile_names.map do |profile_name|
          human_delay
          visit "https://www.instagram.com/#{profile_name}"
          page.find(:xpath, "//a[contains(@href, 'followers') and not(contains(@href, 'mutualOnly'))]").click

          puts "--- #{profile_name}'s follower links fetched ---"
          fetch_follower_links
        end.flatten.uniq
      end

      private

      def fetch_follower_links
        page.find_all(:xpath, "//a[contains(@class, 'FPmhX')]").map do |follower|
          follower[:href]
        end
      end

      def last_promotion_profile_names
        Promotion.last.profile_names.split(' ')
      end

      # def scroll_followers_modal
      #   within page.find(:xpath, "//*[@role='dialog']") do
      #     #scroll
      #   end
      # end
    end
  end
end
