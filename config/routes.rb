Rails.application.routes.draw do
  resources :cards
  resources :users
  resources :decks
  resources :sessions, only: [:new, :create, :destroy]
  root "main#index"
  get "main/index"

  post "check", to: "main#check"
  get "cards", to: "cards#index"

  get "sign_up", to: "users#new", as: :sign_up
  get "log_in", to: "sessions#new", as: :log_in
  delete "log_out", to: "sessions#destroy", as: :log_out

  get "settings", to: "users#settings"

  get "decks", to: "decks#index"
  get "deck/current", to: "decks#current"

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
end
