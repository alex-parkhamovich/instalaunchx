module Automation
  class Like < Base
    def initialize
      visit post_url
      human_delay
      
      post_image.double_click
    end

    private

    def post_url(id: 'Bo9yt_MA-rl')
      "https://www.instagram.com/p/#{id}"
    end

    def post_image
      page.find(:xpath, "//*[@class='_9AhH0']")
    end
  end
end
