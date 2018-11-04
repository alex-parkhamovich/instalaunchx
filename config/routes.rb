Rails.application.routes.draw do
  root 'launchers#index'

  resources :launchers
end
