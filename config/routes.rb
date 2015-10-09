Rails.application.routes.draw do
  
  resources :cards
  
  root "main#index"
  get "main/index"
  get "cards", to: "cards#index"
end
