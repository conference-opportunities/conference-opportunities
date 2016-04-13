Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :organizers, controllers: {omniauth_callbacks: 'organizers/omniauth_callbacks'}
  resources :conferences, only: [:index, :show] do
    scope module: :conferences do
      resource :listing, only: [:new, :create]
      resource :detail, only: [:edit, :update]
    end
  end
  resource :approval, only: [:show]
  root to: 'conferences#index'
end
