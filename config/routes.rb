Rails.application.routes.draw do
  # get 'products/index'
  # get 'products/show'
  # get 'products/new'
  # get 'products/edit'

  root to: 'homepages#index'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
