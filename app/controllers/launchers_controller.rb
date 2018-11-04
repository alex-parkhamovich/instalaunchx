class LaunchersController < ApplicationController
  def index
    @status = Sidekiq::Status::status(
      current_account.current_worker_id
    )
  end

  def create
    if params[:type] == 'start'
      worker_id = LaunchPromotionsWorker.perform_async
      current_account.update_attributes(
        automation_enabled: true,
        current_worker_id: worker_id
      )
        
      redirect_to launchers_path, notice: 'Promotion started'
    else
      current_account.update_attributes(
        automation_enabled: false
      )

      redirect_to launchers_path, notice: 'Promotion stopped'
    end
  end
end
