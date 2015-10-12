Rails.application.routes.draw do
  resources :cards
  root "main#index"
  get "main/index"
  post "check", to: "main#check"
  get "cards", to: "cards#index"
end
