class ApplicationController < ActionController::Base
  def current_account
    Account.first
  end

  def current_promotion
    @current_promotion ||= Promotion.new(
      account_id: 1,
      profile_names: Promotion.first.profile_names,
      tag_names: Promotion.first.tag_names
    )
  end
end
