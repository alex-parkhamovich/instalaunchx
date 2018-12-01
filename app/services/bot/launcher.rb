module Bot
  class Launcher < Base
    def run
      restore_session

      Bot::Promotions::Builder.new.build
      Bot::Followers::Fetcher.new.run
      Bot::Followers::Posts::Liker.new.run
    end
  end
end
