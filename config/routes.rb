Rails.application.routes.draw do

  root to: 'welcome#index'
  devise_for :users

  resources :providers do
    collection do
      get :desactivated
    end
  end

  resources :stores do
    collection do
      get :desactivated
    end
  end

  resources :products do
    collection do
      get :desactivated
    end
  end

  resources :customers do
    collection do
      get :desactivated
    end
  end

  resources :purchases do
    collection do
      get :cancelled
    end
  end

  resources :purchase_details

  resources :dispatches do
    collection do
      get :cancelled
    end
  end

  resources :dispatch_details

  resources :sales do
    collection do
      get :cancelled
    end
  end
  
  resources :sale_details

  resources :plans do
    collection do
      get :desactivated
    end
  end

  resources :expenses do
    collection do
      get :cancelled
    end
  end

  resources :contributions do
    collection do
      get :cancelled
    end
  end

  resources :perfiles

  # devise_for :users, :path_prefix => 'my'
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
end
