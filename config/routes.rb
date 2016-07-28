require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Sidekiq::Web.instance_variable_get(:@middleware).delete_if { |klass,_,_| klass == Rack::Protection }
Sidekiq::Web.set :protection, except: :content_security_policy

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :organizers, controllers: {omniauth_callbacks: 'organizers/omniauth_callbacks'}

  authenticate :organizer, lambda { |organizer| organizer.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :conferences, only: [:index, :show] do
    scope module: :conferences do
      resource :listing, only: [:new, :create]
      resource :detail, only: [:edit, :update]
      resource :structure, only: [:edit, :update]
    end
  end
  resource :approval, only: [:show]
  root to: 'conferences#index'
end
