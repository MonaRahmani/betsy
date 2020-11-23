
Rails.application.routes.draw do


  get '/users/:id/user_dashboard', to: 'users#user_dashboard', as: 'user_dashboard'

  # order matters
  get 'orders/cart', to: 'orders#cart', as: 'cart'
  resources :orders, except: [:index]


  root to: 'homepages#index'
  resources :users do
    resources :products, only: [:index, :new]
  end

  resources :products do
    resources :order_items, only: [:create]
    # resources :categories, only: [:index]
  end

  resources :categories, only: [:new, :create] do
    resources :products, only: [:index]
  end

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create", as:"auth_callback"
  delete "/logout", to: "users#destroy", as: "logout"
end