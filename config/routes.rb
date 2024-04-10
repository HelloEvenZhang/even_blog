Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
  end
end
