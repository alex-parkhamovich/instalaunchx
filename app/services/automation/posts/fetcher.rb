module Automation
  module Posts
    class Fetcher < Base
      attr_accessor :follower_links, :tag_names

      def initialize(follower_links: [], tag_names: [])
        restore_session

        self.follower_links = follower_links
        self.tag_names = tag_names
      end

      def run
        return from_follower_accounts unless follower_links.empty?
        return from_tag_posts unless tag_names.empty?
      end

      private

      def get_only_recent_posts
        post_links = fetch_post_links
        post_links.slice!(0..8)
        post_links
      end

      def fetch_post_links
        page.find_all(:xpath, "//*[@class='v1Nh3 kIKUG  _bz0w']/a").map do |post|
          post[:href]
        end
      end

      def from_follower_accounts
        follower_links.map do |followers_account_link|
          visit followers_account_link

          fetch_post_links.first(2)
        end
      end

      def from_tag_posts
        tag_names.map do |tag_name|
          visit "https://www.instagram.com/explore/tags/#{tag_name}/"

          scroll_to_render_posts
          get_only_recent_posts
        end
      end

      def scroll_to_render_posts
        page.execute_script 'window.scrollBy(0,10000)'
        sleep(1)
        page.execute_script 'window.scrollBy(0,10000)'
      end
    end
  end
end
