module Automation
  module Posts
    class Fetcher < Base
      attr_accessor :follower_links, :tag_names

      def initialize(follower_links: [], tag_names: [])
        restore_session
        resize_window

        self.follower_links = follower_links
        self.tag_names = tag_names
      end

      def run
        post_links = []
        post_links << from_follower_accounts unless follower_links.empty?
        post_links << from_tag_posts unless tag_names.empty?

        puts "--- #{post_links.count} ---"
        post_links.flatten
      end

      private

      def get_only_recent_uniq_posts
        post_links = fetch_post_links
        post_links.slice!(0..8)
        post_links.uniq
      end

      def fetch_post_links
        page.find_all(:xpath, "//*[@class='v1Nh3 kIKUG  _bz0w']/a").map do |post|
          post[:href]
        end
      end

      def from_follower_accounts
        follower_links.map do |followers_account_link|
          return unless current_account.automation_enabled
          human_delay

          visit followers_account_link

          puts "--- #{followers_account_link}'s posts fetched ---"
          links = fetch_post_links.first(4)
          links.delete_at(1)
          links
        end
      end

      def from_tag_posts
        tag_names.map do |tag_name|
          return unless current_account.automation_enabled
          human_delay

          visit "https://www.instagram.com/explore/tags/#{tag_name}/"
          scroll_to_render_posts

          puts "--- ##{tag_name}'s posts fetched ---"
          get_only_recent_uniq_posts
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
