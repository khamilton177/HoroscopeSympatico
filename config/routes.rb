Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  root "zodiacs#index"
  get "/zodiac/:sign", to: "zodiacs#show", as: :zodiac
  # get "/users/:user_id/journals/new", to: "journals#new", as: :user_root

  # get "/users/:user_id/journals/new", to: "journals#new", as: :user_root
  # post "/users/:user_id/journals", to: "journals#create"
  # get "/predict/:id", to: "predicts#show", as: :user_root
  # post "/predicts", to: "predicts#create", as: :user_root
  devise_for :users

  devise_scope :users do
    get "/users/resource_name.id/zodiac/home", to: "zodiacs#show", as: :user_root
  end

  # Create routes for users to their journals
  resources :journals

  # get "/journals/:user_id/journals" => "journals#my_journal", as: "my_journals"

  #simple routes syntac
  # method "controller/path_URI"
  # match routes syntax
  # match "controller/path_URI" to: controller#action via: verb_method as: prefix_path
  # default route syntax
  # get 'controller(/:action(/:id))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
