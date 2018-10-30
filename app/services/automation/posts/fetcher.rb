module Automation
  module Posts
    class Fetcher < Base
      def initialize
        restore_session
      end

      def run(tag_name = 'e36')
        visit "https://www.instagram.com/explore/tags/#{tag_name}/"

        fetch_links_from_posts
      end

      private

      def fetch_links_from_posts
        posts_links = []
        page.find_all(:xpath, "//*[@class='v1Nh3 kIKUG  _bz0w']/a").each do |post|
          posts_links << post[:href]
        end
        posts_links
      end

      def first_post_on_board
        page.find_all(:xpath, "//a[contains(@href, 'taken-by')]").first
      end
    end
  end
end
