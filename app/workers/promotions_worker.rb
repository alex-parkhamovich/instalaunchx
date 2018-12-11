class PromotionsWorker < BaseWorker
  def perform
    Bot::Followers::Posts::Liker.new.run
  end
end
