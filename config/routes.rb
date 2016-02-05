Rails.application.routes.draw do
  resources :conferences, only: [:index, :show]
  devise_for :conference_organizers, controllers: {omniauth_callbacks: 'conference_organizers/omniauth_callbacks'}
  root to: 'conferences#index'
end
