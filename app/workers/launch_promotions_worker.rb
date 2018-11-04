class LaunchPromotionsWorker < BaseWorker
  def perform
    Automation::Launcher.new.rise
  end
end
