Rails3BootstrapDeviseCancan::Application.routes.draw do
  get "errors/not_fount"

  get "errors/server_error"

  resources :constant_texts do
    member do
      get 'pay_state', 'changes_state','contact_state', 'store_intro',
        'who_we_are', 'how_to_buy','delivery_area', 'privacy_state',
        'cookies_state'
    end
  end

  match '/404', :to => 'errors#not_found'
  match '/422', :to => 'errors#server_error'
  match '/500', :to => 'errors#server_error'

  resources :short_supply_registrations
  resources :orders do
    member do
      put :products_sended
    end
  end 
  resources :banners
  resources :categories
  resources :line_items
  get "/filter_by_stock" => "products#filter_by_stock"
  get "/finished_orders" => "orders#finished_orders"
  get "/unfinished_orders" => "orders#unfinished_orders"
  get "/ajax_change_price" => "line_items#ajax_change_price"
  get "/unvisiable_all" => "banners#unvisiable_all"
  get "/change_color" => "line_items#change_color"
  get "/about" => "home#about"
  resources :carts
  resources :products do 
    collection { post :import }
  end
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end
