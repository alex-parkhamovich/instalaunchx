class LaunchersController < ApplicationController
  def index
    # @status = Sidekiq::Status::status(current_promotion.worker_uuid)

    # current_promotion.update_attributes(status: @status)
  end

  def create
    # if params[:type] == 'start'
    #   worker_uuid = LaunchPromotionsWorker.perform_async

    #   current_account.update_attributes(automation_enabled: true)
    #   current_promotion.update_attributes(worker_uuid: worker_uuid)

    #   redirect_to launchers_path, notice: 'Promotion started'
    # else
    #   current_account.update_attributes(automation_enabled: false)

    #   redirect_to launchers_path, notice: 'Promotion will be stopped'
    # end
  end
end
