Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  root to: "pages#home"
  get 'authorized', to: 'sessions#page_requires_login'
  resources :bills
  resources :price_lists
  resources :clients
  resources :sales
  resources :sale_details
  resources :categories
  resources :products
  resources :pages

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   
end
