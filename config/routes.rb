Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :promotions, only: [:create]
  resources :followers_packs, only: [:create]
end
