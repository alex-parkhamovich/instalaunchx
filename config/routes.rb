Rails.application.routes.draw do
  root 'captains#index'

  resources :captains
end
