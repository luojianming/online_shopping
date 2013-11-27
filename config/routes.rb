Rails3BootstrapDeviseCancan::Application.routes.draw do
  resources :short_supply_registrations


  resources :orders 
  
  resources :banners

  resources :categories

  resources :line_items

  get "/filter_by_stock" => "products#filter_by_stock"
  get "/finished_orders" => "orders#finished_orders"
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
