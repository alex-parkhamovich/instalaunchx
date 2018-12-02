# # Bot::Followers::Posts::Fetcher.new.run

# module Bot
#   module Followers
#     module Posts
#       class Fetcher < Base
#         attr_accessor :followers

#         def initialize
#           restore_session

#           self.followers = current_promotion.followers_pack.followers
#         end

#         def run
#           followers.each do |follower_profile_url|
#             return puts '--- automation disabled for current account ---' unless current_account.automation_enabled
#             return puts '--- todays likes count is more than 900 for current account ---' if todays_likes_limit_reached?

#             visit follower_profile_url
#             next if profile_private_or_already_liked?(follower_profile_url)
#           end
#         end
#       end
#     end
#   end
# end
