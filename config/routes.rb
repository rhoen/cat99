Cats99::Application.routes.draw do

  resources :cats #do
  #   resources :cat_rental_requests
  # end

  resources :cat_rental_requests do
    patch 'approve', on: :member 
    patch 'deny', on: :member
  end
end
