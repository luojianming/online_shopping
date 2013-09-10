Rails3BootstrapDeviseCancan::Application.routes.draw do
  resources :orders


  resources :line_items


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
