class FollowersPacksController < ApplicationController
  before_action :find_promotion

  def create
    promotion = find_promotion
    worker_uuid = FollowersPacksWorker.perform_async

    promotion.update_attributes(worker_uuid: worker_uuid, status: 'fetching')
  end

  private

  def find_promotion
    Promotion.find(params[:promotion_id].to_i)
  end
end
