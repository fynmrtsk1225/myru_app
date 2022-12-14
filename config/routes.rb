Rails.application.routes.draw do
  root "homes#index"
  
  resources :homes, only: [:index]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
  end
  
  devise_for :users, controllers: { registrations: 'users/registrations' }, path: 'user'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :users, only: [:index, :show] do
    collection do
      get 'search'
    end
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
  
  resources :profiles, only: [:edit, :update]
  
  resources :tags
  resources :pictures do
    collection do
      get 'search'
    end
  end
  
  resources :favorite_pictures, only: [:index]
  post 'favorite_picture/:id' => 'favorite_pictures#create', as: 'create_favorite_picture'
  delete 'favorite_picture/:id' => 'favorite_pictures#destroy', as: 'destroy_favorite_picture'
  
  resources :products, only: [:index, :show] do
    collection do
      get 'search'
    end
  end
  
  resources :favorite_products, only: [:index]
  post 'favorite_product/:id' => 'favorite_products#create', as: 'create_favorite_product'
  delete 'favorite_product/:id' => 'favorite_products#destroy', as: 'destroy_favorite_product'

  resources :room_ideas
end