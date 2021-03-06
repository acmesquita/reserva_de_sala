Rails.application.routes.draw do
  # get 'reservations/index'
  # get 'reservations/new'
  # get 'reservations/edit'
  
  resources :reservations, only: [:index, :create, :new, :show, :destory]
  devise_for :users

  authenticated :user do
    root to: 'reservations#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
