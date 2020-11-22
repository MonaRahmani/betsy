
Rails.application.routes.draw do

  # cart

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
  end

  resources :categories, only: [:new, :create] do
    resources :products, only: [:index]
  end





  # get '/products', to: 'products#index', as: 'products'
  # get '/products/new', to: 'products#new', as: 'new_product'sch
  # post '/products', to: 'products#create'
  # get '/products/:id', to: 'products#show', as: 'product'
  # get '/products/:id/edit', to: 'products#edit', as: 'edit_product'
  # patch '/products/:id', to: 'products#update'
  # delete '/products/:id', to: 'products#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create", as:"auth_callback"
  delete "/logout", to: "users#destroy", as: "logout"
end