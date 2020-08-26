Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    get   'users/new_address',    to: 'users/registrations#new_address'
    post  'users/create_address', to: 'users/registrations#create_address'
    get   'users/edit_address',   to: 'users/registrations#edit_address'
    patch 'users/update_address', to: 'users/registrations#update_address' 
    get   'users/select',         to: 'users/registrations#select'
  end

  root "products#index"
  resources :products 
    resources :carts do
      collection do
        post "cart_in", to: "carts#cart_in"
      end
    end

  resources :users, only: [:show]
  resources :carts, only: [:index, :destroy]
  resources :cards
end
