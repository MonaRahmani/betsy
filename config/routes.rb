Rails.application.routes.draw do

  # cart
  get 'user/cart', to: 'order_item#cart', as: 'cart'
  post 'products/:id/add-to-cart', to: 'order_item#add_to_cart', as: 'add_to_cart'
  post 'guest/cart/remove', to: 'order_item#remove_from_cart', as: 'remove_from_cart'


  resources :orders


  root to: 'homepages#index'
  resources :users do
    resources :products, only: [:index, :new]
  end

  resources :products
  resources :categories, only: [:new, :create]

  # get '/products', to: 'products#index', as: 'products'
  # get '/products/new', to: 'products#new', as: 'new_product'
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
