module Automation
  class Captain < Base
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
        tag_names: ['followtofollow']
      ).run
    end
  end
end
