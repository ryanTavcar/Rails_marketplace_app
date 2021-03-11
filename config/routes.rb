Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users
  resources :profiles
  root to: "home#index"
  resources :products
  post 'payments/webhook', to: 'payments#webhook'
  get 'payments/success', to: 'home#payment_success'
  
  # Product routes
  #get "/product", to: "products#index", as: "products"
  #post "/products", to: "products#create"
  #get "/products/new", to: "products#new", as: "new_products"
  #get "/products/:id/edit", to: "products#edit", as: "edit_products"
  #get "/products/:id", to: "products#show", as: "product"
  #patch "/products/:id", to: "products#update"
  #put "/products/:id", to: "products#update"
  #delete "/products/:id", to: "products#destroy"
end
