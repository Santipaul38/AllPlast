Rails.application.routes.draw do
  get 'pages/home'
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
   root to: "pages#home"
end
