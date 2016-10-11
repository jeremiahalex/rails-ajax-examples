Rails.application.routes.draw do
  root 'static#index'

  resources :things
  resources :stuffs, controller: :stuff
end
