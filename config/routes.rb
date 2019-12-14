Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :videos, only: [:create]
  get 'share', to: 'videos#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
