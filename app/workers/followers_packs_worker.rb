class FollowersPacksWorker < BaseWorker
  def perform
    Bot::Followers::Fetcher.new.run
  end
end
