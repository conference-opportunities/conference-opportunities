Rails.application.routes.draw do
  resources :conferences, only: [:index, :show]
  root to: 'conferences#index'
end
