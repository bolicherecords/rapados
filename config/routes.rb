Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users
  resources :providers
  resources :stores
  resources :products
  resources :clients
  resources :purchases
  resources :sales

  # devise_for :users, :path_prefix => 'my'
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
end
