Rails.application.routes.draw do
  resources :cards
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  root "main#index"
  get "main/index"
  post "check", to: "main#check"
  get "cards", to: "cards#index"
  get "sign_up", to: "users#new", as: :sign_up
  get "log_in", to: "sessions#new", as: :log_in
  delete "log_out", to: "sessions#destroy", as: :log_out
end
