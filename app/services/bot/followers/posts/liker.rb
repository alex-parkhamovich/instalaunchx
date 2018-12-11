# Bot::Followers::Posts::Liker.new.run

module Bot
  module Followers
    module Posts
      class Liker < Base
        attr_accessor :followers

        def initialize
          restore_session

          self.followers = current_followers_pack.followers
        end

        def run
          new_followers = followers.drop(last_processed_index)
          new_followers.each.with_index(last_processed_index) do |follower_profile_url, index|
            return puts '--- automation disabled for current account ---' unless current_account.automation_enabled
            return puts '--- todays likes count is more than 900 for current account ---' if todays_likes_limit_reached?

            update_last_processed_index(index)

            visit follower_profile_url
            next if profile_without_posts_or_private?(follower_profile_url)

            puts "--- #{follower_profile_url} posts liking process is started ---"
            like_followers_posts
            puts "--- #{follower_profile_url} posts successfully liked ---"
          end
          puts '--- PROMO COMPLETED ---'
        end

        private

        def count_metrics
          Bot::LikesCounters::Builder.new.build
        end

        def last_processed_index
          current_followers_pack.last_processed_index
        end

        def fetch_posts_urls
          post_urls = page.find_all(:xpath, "//a[contains(@href, '/p/')]")
            .first(4)
            .map { |post| post[:href] }
          post_urls.delete_at(2)
          post_urls
        end

        def like_followers_posts
          post_urls = fetch_posts_urls
          return if post_urls.empty?

          post_urls.each do |post_url|
            visit post_url
            next if post_already_liked?(post_url)

            press_heart_button

            puts "--- #{post_url} successfully liked ---"
          end
        end

        def press_heart_button
          around_like_delay
          page.find(:xpath, "//button[contains(@class, 'coreSpriteHeartOpen')]").click
          count_metrics
          around_like_delay
        end

        def post_already_liked?(post_url)
          if page.has_xpath?("//*[@aria-label='Unlike']")
            puts "--- #{post_url} have already liked ---"
            return true
          end
        end

        def profile_without_posts_or_private?(follower_profile_url)
          if page.has_content?('This Account is Private')
            puts "--- #{follower_profile_url} is private ---"
            return true
          end
          if page.has_content?('No Posts Yet')
            puts "--- #{follower_profile_url} has no posts yet ---"
            return true
          end
        end

        def update_last_processed_index(index)
          Bot::FollowersPacks::Builder.new.update(index: index)
        end
      end
    end
  end
end
