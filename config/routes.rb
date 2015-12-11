Rails.application.routes.draw do
  resources :conferences, only: :show

end
