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

            visit follower_profile_url + 'feed'
            next if profile_private_or_already_liked?(follower_profile_url)

            puts "--- #{follower_profile_url} posts liking process is started ---"
            like_followers_posts
            puts "--- #{follower_profile_url} posts successfully liked ---"
          end
        end

        private

        def count_likes_metric
          Bot::LikesCounters::Builder.new.build
        end

        def find_all_heart_buttons
          wait_until_posts_load

          page.find_all(
            :xpath,
            "//button[contains(@class, 'coreSpriteHeartOpen')]"
          )
        end

        def like_followers_posts
          find_all_heart_buttons.each_with_index do |button, index|
            unless index == 2 || index > 3
              press_heart_button(button)
              puts "--- post number #{index + 1} successfully liked ---"
            end
          end
        end

        def press_heart_button(button)
          around_like_delay
          button.click
          count_likes_metric
          around_like_delay
        end

        def profile_private_or_already_liked?(follower_profile_url)
          if page.has_content?('This Account is Private')
            puts "--- #{follower_profile_url} is private ---"
            return true
          end
          if page.has_xpath?("//*[@aria-label='Unlike']")
            puts "--- #{follower_profile_url} have already liked ---"
            return true
          end
          if page.has_content?('No Posts Yet')
            puts "--- #{follower_profile_url} has no posts yet ---"
            return true
          end
        end

        def stop_working
          current_account.update_attributes(
            automation_enabled: false,
            current_worker_id: nil
          )
        end

        def wait_until_posts_load
          page.execute_script 'window.scrollBy(0, 1000)'
          sleep(5)
          page.execute_script 'window.scrollBy(0, 1000)'
        end
      end
    end
  end
end
