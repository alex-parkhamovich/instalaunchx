class LaunchPromotionsWorker < BaseWorker
  def perform
    Bot::Launcher.new.rise
  end
end
