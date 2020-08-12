Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  devise_scope :user do
    get 'users/new_address' => 'users/registrations#new_address'
    post 'users/create_address' => 'users/registrations#create_address'
  end
end
