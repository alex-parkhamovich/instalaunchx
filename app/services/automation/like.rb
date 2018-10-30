module Automation
  class Like < Base
    attr_accessor :follower

    def initialize(follower)
      self.follower = follower
    end

    def like
      visit followers_page
      human_delay
      
      like_post unless page.has_content?('This Account is Private') || page.has_content?('No Posts Yet')
    end

    private

    def like_post
      first_post_on_board.click
      human_delay
      heart.click
      human_delay
    end

    def post_url(id: 'Bo9yt_MA-rl')
      "https://www.instagram.com/p/#{id}"
    end

    def followers_page
      "https://www.instagram.com/#{follower}"
    end

    def post_image
      page.find(:xpath, "//*[@class='_9AhH0']")
    end

    def first_post_on_board
      page.find_all(:xpath, "//a[contains(@href, 'taken-by')]").first
    end

    def heart
      page.find(:xpath, "//button[contains(@class, 'coreSpriteHeartOpen')]")
    end
  end
end
