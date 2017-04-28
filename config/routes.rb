Rails.application.routes.draw do
  root to: "rentals#index"
  resources :rentals
  resources :bookings
end
