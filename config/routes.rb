Rails.application.routes.draw do

  root to: "home#index"
  get "/zodiac/:id", to: "zodiacs#show", as: :zodiac
  get "/users/:user_id/journals/new", to: "journals#new", as: :user_root

  # get "/users/:user_id/journals/new", to: "journals#new", as: :user_root
  # post "/users/:user_id/journals", to: "journals#create"
  # get "/predict/:id", to: "predicts#show", as: :user_root
  # post "/predicts", to: "predicts#create", as: :user_root
  devise_for :users

  # Create routes for users to their journals
  resources :users do
    resources :journals
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
