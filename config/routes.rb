Rails.application.routes.draw do
  root to: 'splash_page#index'
  get '/home', to: 'home#index', as: :home
  get '/products', to: 'products#index'
  get '/dashboard', to: 'dashboard#index'
  get '/show-collection', to: "dashboard#show_collection", as: 'show_collection'
  get '/manual-uninstall', to: "dashboard#manual_uninstall", as: 'manual_uninstall'

  resources :shops
  resources :products
  post 'products/bulk', to: 'products#bulk', as: 'bulk'
  resources :preferences
  resources :variants

  # ajax calls from shop
  get 'unit_prices/:shopify_id', to: "unit_prices#show"
  post 'unit_prices/:shopify_id', to: "unit_prices#update"
  get 'unit_prices_variants/:shopify_id', to: "unit_prices#show_variant"

  resources :widgets
  get 'splash_page/index', to: 'splash_page#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
