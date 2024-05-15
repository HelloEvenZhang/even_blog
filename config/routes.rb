Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"

  get 'about', to: 'home#about'
  get 'admin', to: 'admin/dashboard#index'

  resources :posts, only: [:index, :show] do
    resources :comments, only: [:create]
    collection do
      get :search
    end
  end

  namespace :admin do
    resources :posts do
      resources :comments, only: [:index, :destroy]
      collection do
        get :search
      end
    end
    resources :tags
  end
end
