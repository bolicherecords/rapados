Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users
  resources :providers do
    collection do
      get :desactivated
      get 'toggle_activated/:id' => 'providers#desactivated', as: :toggle_activated
    end
  end
  resources :stores
  resources :products
  resources :clients

  resources :purchases
  resources :purchase_details

  resources :dispatches
  resources :dispatch_details

  resources :sales
  resources :sale_details

  # devise_for :users, :path_prefix => 'my'
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

end
