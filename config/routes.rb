Rails.application.routes.draw do
  resources :log_items
  resources :tire_sets
  resources :vehicles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
