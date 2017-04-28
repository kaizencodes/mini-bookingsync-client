Rails.application.routes.draw do
  root to: "rentals#index"
  resources :rentals
end
