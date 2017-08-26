Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users
  resources :providers
  resources :stores
  resources :products
  resources :clients

  resources :purchases
  resources :purchase_details

  resources :dispatches
  resources :dispatch_details

  resources :sales
  resources :sale_details
  
end
