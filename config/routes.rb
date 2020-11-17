Rails.application.routes.draw do
<<<<<<< HEAD
  get 'products/index'
  get 'products/show'
  get 'products/new'
  get 'products/edit'
=======
  root to: 'homepages#index'
  resources :users
>>>>>>> ef6fa71ed2782a8e291aabade0d99b7085a4375f
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
