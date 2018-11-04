ActiveAdmin.setup do |config|
  config.authentication_method = :authenticate_admin_user!
  config.batch_actions = true
  config.current_user_method = :current_admin_user
  config.comments = false
  config.localize_format = :long
  config.logout_link_path = :destroy_admin_user_session_path
  config.site_title = "InstaLaunchX"
end
