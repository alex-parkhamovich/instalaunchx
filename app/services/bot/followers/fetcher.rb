# Bot::Followers::Fetcher.new.run

module Bot
  module Followers
    class Fetcher < Base
      def initialize
        restore_session

        create_promotion
      end

      def run
        current_promotion.update_attributes(
          followers: perform_fetching
        )
      end

      private

      def create_promotion
        Promotion.create(
          account: current_account,
          profile_names: 'e36.only e36fanatics'
        )
      end

      def collect_follower_links
        page.find_all(:xpath, "//a[contains(@class, 'FPmhX')]").map do |follower|
          follower[:href]
        end
      end

      def current_promotion_profile_names
        current_promotion.profile_names.split(' ')
      end

      def fetch_followers
        open_followers_container
        wait_until_links_render
        collect_follower_links
      end

      def open_followers_container
        page.find(
          :xpath,
          "//a[contains(@href, 'followers') and " \
          "not(contains(@href, 'mutualOnly'))]"
        ).click
      end

      def perform_fetching
        current_promotion_profile_names.map do |profile_name|
          return unless current_account.automation_enabled

          visit "https://www.instagram.com/#{profile_name}"

          puts "--- #{profile_name}'s follower links is fetching ---"
          fetch_followers
        end.flatten.uniq
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
