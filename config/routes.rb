Rails.application.routes.draw do
  resources :conferences, only: :show

  get 'home/show'
  root to: 'home#show'
end
