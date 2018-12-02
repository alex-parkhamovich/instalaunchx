# Bot::Followers::Posts::Liker.new.run

module Bot
  module Followers
    module Posts
      class Liker < Base
        attr_accessor :followers

        def initialize
          restore_session

          self.followers = current_promotion.followers_pack.followers
        end

        def run
          followers.each do |follower_profile_url|
            return puts '--- automation disabled for current account ---' unless current_account.automation_enabled
            return puts '--- todays likes count is more than 900 for current account ---' if todays_likes_limit_reached?

            visit follower_profile_url
            next if profile_without_posts_or_private?(follower_profile_url)

            puts "--- #{follower_profile_url} posts liking process is started ---"
            like_followers_posts
            puts "--- #{follower_profile_url} posts successfully liked ---"
          end
        end

        private

        def count_likes_metric
          Bot::LikesCounters::Builder.new.build
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
          count_likes_metric
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
      end
    end
  end
end
