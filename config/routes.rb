Rails.application.routes.draw do
  root to: 'splash_page#index'
  get '/home', to: 'home#index', as: :home
  get '/products', to: 'products#index'
  get '/dashboard', to: 'dashboard#index'
  get '/show-collection', to: "dashboard#show_collection", as: 'show_collection'
  get '/manual-uninstall', to: "dashboard#manual_uninstall", as: 'manual_uninstall'


  resources :widgets
  get 'splash_page/index', to: 'splash_page#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
