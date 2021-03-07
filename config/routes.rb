Rails.application.routes.draw do
  devise_for :users
  root to: "listings#index"
  resources :products

  # Product routes
  get "/products", to: "products#index", as: "products"
  post "/products", to: "products#create"
  get "/products/new", to: "products#new", as: "new_products"
  get "/products/:id/edit", to: "products#edit", as: "edit_products"
  get "/products/:id", to: "products#show", as: "product"
  patch "/products/:id", as: "products#update"
  put "/products/:id", as: "products#update"
  delete "/products/:id", as: "products#destroy"
end
