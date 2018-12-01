module Bot
  module LikesCounters
    class Builder < Base
      def initialize
      end

      def build
        if current_likes_counter
          increment_likes_count
        else
          create_new_counter
        end
      end

      private

      def create_new_counter
        LikesCounter.create(
          account: current_account,
          amount: 1
        )
      end

      def current_likes_counter
        LikesCounter.find_by(
          account: current_account,
          created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
        )
      end

      def increment_likes_count
        current_likes_counter.update_attributes(
          amount: current_likes_counter.amount += 1
        )
      end
    end
  end
end
