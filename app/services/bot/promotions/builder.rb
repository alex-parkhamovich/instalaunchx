module Bot
  module Promotions
    class Builder < Base
      attr_accessor :profile_names

      def initialize(profile_names: 'e36.only e36fanatics')
        self.profile_names = profile_names
      end

      def build
        Promotion.create(
          account: current_account,
          profile_names: profile_names
        )
      end
    end
  end
end
