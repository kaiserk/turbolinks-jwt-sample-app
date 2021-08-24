Rails.application.routes.draw do
  root  'dashboard#index' # old way
  # root to: 'splash_page#index'
  # get '/home', to: 'home#index', as: :home
  # get '/products', to: 'products#index'
  get '/dashboard', to: 'dashboard#index'
  get '/show-collection', to: "dashboard#show_collection", as: 'show_collection'
  get '/manual-uninstall', to: "dashboard#manual_uninstall", as: 'manual_uninstall'

  get 'widget', to: "scripts#widget", :as => 'widget' #re-enable when ready
  get 'thanks', to: "charges#thanks", as: 'thanks'
  get 'charge', to: "charges#new", as: 'charge'
  get 'create', to: "charges#create", as: 'create'

  resources :shops
  resources :products
  post 'products/bulk', to: 'products#bulk', as: 'bulk'
  resources :preferences
  resources :variants

  # in-app UX
  get 'results/:query', to: 'searches#show'

  # webhooks
  # match 'uninstall', to: 'webhook#uninstall', via: [:get, :post]
  match 'webhooks/product_update', to: 'webhook#product_update', via: [:get, :post]

  #GDPR webhooks
  match 'customers/data_erase', to: 'webhook#customers_redact', via: [:post]
  match 'customers/data_request', to: 'webhook#customers_data_request', via: [:post]
  match 'shop/data_erase', to: 'webhook#shop_redact', via: [:post]

  # ajax calls from shop
  get 'unit_prices/:shopify_id', to: "unit_prices#show"
  post 'unit_prices/:shopify_id', to: "unit_prices#update"
  get 'unit_prices_variants/:shopify_id', to: "unit_prices#show_variant"

  # resources :widgets
  get 'splash_page/index', to: 'splash_page#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
