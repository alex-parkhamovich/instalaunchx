module Automation
  module Posts
    class Liker < Base
      attr_accessor :post_links

      def initialize(post_links: [])
        self.post_links = post_links.flatten
      end

      def run
        post_links.each do |post_link|
          return unless current_account.automation_enabled

          visit post_link

          press_like_button unless page.has_xpath?("//*[@aria-label='Unlike']")
        rescue
          next
        end

        current_account.update_attributes(
          automation_enabled: false,
          current_worker_id: nil
        )

        puts '--- Promotion successfully ended ---'
      end

      private

      def count_likes_metric
        current_account.update_attributes(
          likes_count: current_account.likes_count += 1
        )

        puts '--- Successfully liked ---'
      end

      def press_like_button
        around_like_delay
        page.find(:xpath, "//button[contains(@class, 'coreSpriteHeartOpen')]").click
        count_likes_metric
        around_like_delay
      end
    end
  end
end
