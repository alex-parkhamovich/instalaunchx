module Bot
  class Launcher < Base
    def rise
      restore_session

      Bot::Posts::Liker.new(post_links: fetch_post_links).run
    end

    private

    def fetch_follower_links
      Bot::Followers::Fetcher.new.run
      current_promotion.followers
    end

    def fetch_post_links
      Bot::Posts::Fetcher.new(
        follower_links: fetch_follower_links
      ).run
    end

    def last_promotion_tag_names
      Promotion.last.tag_names.split(' ')
    end
  end
end