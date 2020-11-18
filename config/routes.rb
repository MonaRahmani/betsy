Rails.application.routes.draw do

  get 'orders/index'
  get 'orders/show'
  get 'orders/edit'
  get 'orders/new'
  # get 'products/index'
  # get 'products/show'
  # get 'products/new'
  # get 'products/edit'

  root to: 'homepages#index'
  resources :users
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
