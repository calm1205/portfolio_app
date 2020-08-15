Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  devise_scope :user do
    get   'users/new_address',    to: 'users/registrations#new_address'
    post  'users/create_address', to: 'users/registrations#create_address'
    get   'users/edit_address',   to: 'users/registrations#edit_address'
    patch 'users/update_address', to: 'users/registrations#update_address' 
  end

  root "products#index"
  resources :products do
    member do
      post "cart_in"
      patch "cart_in"
    end
  end
  resources :users, only: [:show]
end
