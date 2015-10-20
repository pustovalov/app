Rails.application.routes.draw do
  resources :cards
  resources :users, only: [:new, :create]
  root "main#index"
  get "main/index"
  post "check", to: "main#check"
  get "cards", to: "cards#index"
  get "sign_up", to: "users#new", as: :sign_up
end
