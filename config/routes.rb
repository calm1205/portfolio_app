Rails.application.routes.draw do
  root "products#index"
  devise_for :users
  resources :products do
    member do
      post "cart_in"
      patch "cart_in"
    end
  end
end
