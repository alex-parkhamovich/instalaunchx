module Automation
  class Launcher < Base
    def rise
      restore_session

      Automation::Posts::Liker.new(post_links: fetch_post_links).run
    end

    private

    def fetch_follower_links
      Automation::Followers::Fetcher.new.run
    end

    def fetch_post_links
      Automation::Posts::Fetcher.new(
        follower_links: fetch_follower_links
      ).run
    end

    def last_promotion_tag_names
      Promotion.last.tag_names.split(' ')
    end
  end
end
