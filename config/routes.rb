Rails.application.routes.draw do
  resources :bill_items
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/login'
  get 'sessions/close'
  get 'users/new'
  get 'users/create'
  get 'pages/home'
  get 'pages/stock'

  get 'authorized', to: 'sessions#page_requires_login'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  post 'sales/deleteDetail'
  post 'products/deleteCategory'

  resources :bills
  resources :price_lists
  resources :clients
  resources :sales
  resources :sale_details
  resources :categories
  resources :products
  resources :pages
  resources :users, only: [:new, :create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root to: "sessions#login"
end
