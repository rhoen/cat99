Cats99::Application.routes.draw do

  resources :cats #do
  #   resources :cat_rental_requests
  # end

  root 'sessions#new' 

  resources :cat_rental_requests do
    patch 'approve', on: :member
    patch 'deny', on: :member
  end

  resources :users, only: [:new, :create, :index, :show]

  resource :sessions, only: [:new, :create, :destroy]

end
