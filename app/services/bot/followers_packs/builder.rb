module Bot
  module FollowersPacks
    class Builder < Base
      attr_accessor :followers

      def initialize(followers: [])
        self.followers = followers
      end

      def build
        create_new_followers_pack
      end

      def update(index:)
        current_followers_pack.update_attributes(
          last_processed_index: index
        )
      end

      private

      def create_new_followers_pack
        FollowersPack.create(
          promotion: current_promotion,
          followers: followers
        )
      end

      def current_followers_count
        current_followers_pack.followers.count
      end
    end
  end
end
