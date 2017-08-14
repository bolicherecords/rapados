Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users
  resources :providers
  resources :stores
  resources :products
  resources :clients
  resources :purchases
  resources :sales
end
