module Bot
  module Followers
    class Fetcher < Base
      def initialize
        restore_session
      end

      def run
        links = current_promotion_profile_names.map do |profile_name|
          return unless current_account.automation_enabled
          human_delay

          visit "https://www.instagram.com/#{profile_name}"

          puts "--- #{profile_name}'s follower links is fetching ---"
          fetch_followers
        end.flatten.uniq

        binding.pry
        puts "--- #{links.count} ---"
        links
      end

      private

      def collect_follower_links
        page.find_all(:xpath, "//a[contains(@class, 'FPmhX')]").map do |follower|
          follower[:href]
        end
      end

      def fetch_followers
        resize_window('mobile')

        open_followers_page
        wait_until_links_render
        links = collect_follower_links

        puts '--- Fetch succeed. #{links.count} fetched ---'
        links
      end

      def current_promotion_profile_names
        current_promotion.profile_names.split(' ')
      end

      def open_followers_page
        page.find(
          :xpath,
          "//a[contains(@href, 'followers') and " \
          "not(contains(@href, 'mutualOnly'))]"
        ).click
      end

      def wait_until_links_render
        7.times do
          page.execute_script 'window.scrollBy(0, 100000)'
          human_delay
        end
      end
    end
  end
end
