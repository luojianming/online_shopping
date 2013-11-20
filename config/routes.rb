Rails3BootstrapDeviseCancan::Application.routes.draw do
  resources :orders 

  resources :categories

  resources :line_items

  get "/finished_orders" => "orders#finished_orders"
  get "/ajax_change_price" => "line_items#ajax_change_price"
  get "/change_color" => "line_items#change_color"
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
