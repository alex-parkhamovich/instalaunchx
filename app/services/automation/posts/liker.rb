module Automation
  module Posts
    class Liker < Base
      def initialize
        @metric = 0
      end

      def run(posts_links = [])
        posts_links.each do |link|
          visit link

          press_like_button
          count_likes_metric

          puts 'Successfully liked'
        end

        puts "#{@metric} posts liked overall"
      end

      private

      def press_like_button
        around_like_delay
        page.find(:xpath, "//button[contains(@class, 'coreSpriteHeartOpen')]").click
        around_like_delay
      end

      def count_likes_metric
        @metric += 1
      end
    end
  end
end
