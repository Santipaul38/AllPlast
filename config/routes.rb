Rails.application.routes.draw do
  resources :bills
  resources :price_lists
  resources :clients
  resources :sales
  resources :sale_details
  resources :categories
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "products#index"
end
