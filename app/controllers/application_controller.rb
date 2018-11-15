class ApplicationController < ActionController::Base
  def current_account
    Account.first
  end

  def current_promotion
    Promotion.last
  end
end
