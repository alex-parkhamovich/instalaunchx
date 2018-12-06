class ApplicationController < ActionController::Base
  def current_account
    Account.first
  end
end
