module Bot
  module Posts
    class Liker < Base
      attr_accessor :post_links

      def initialize(post_links: [])
        self.post_links = post_links
      end

      def run
        post_links.each do |post_link|
          return unless current_account.automation_enabled

          visit post_link
          press_like_button(post_link) unless page.has_xpath?("//*[@aria-label='Unlike']")
        rescue
          next
        end

        stop_working

        puts '--- Promotion successfully ended ---'
      end

      private

      def count_likes_metric
        current_promotion.update_attributes(
          likes_count: current_promotion.likes_count += 1
        )
      end

      def press_like_button(post_link)
        around_like_delay
        page.find(:xpath, "//button[contains(@class, 'coreSpriteHeartOpen')]").click
        count_likes_metric
        around_like_delay

        puts "--- #{post_link} successfully liked ---"
      end

      def stop_working
        current_account.update_attributes(
          automation_enabled: false,
          current_worker_id: nil
        )
      end
    end
  end
end
