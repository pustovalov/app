Rails.application.routes.draw do
  scope module: "dashboard" do
    resources :cards
    resources :decks
    get "decks", to: "decks#index"
    get "deck/current", to: "decks#current"
    post "check", to: "main#check"
    get "cards", to: "cards#index"
  end

  scope module: "home" do
    resources :users
    resources :password_resets, only: [:new, :create, :update, :edit]
    resources :sessions, only: [:new, :create, :destroy]

    get "sign_up", to: "users#new", as: :sign_up
    get "log_in", to: "sessions#new", as: :log_in
    post "password_resets/new"
    delete "log_out", to: "sessions#destroy", as: :log_out
    get "settings", to: "users#settings"
    get "main/index"
    post "oauth/callback", to: "oauths#callback"
    get "oauth/callback", to: "oauths#callback"
    get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  end

  root "dashboard/main#index"
end
