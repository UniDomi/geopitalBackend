Rails.application.routes.draw do
  resources :uploads, only: [:index, :new, :create, :destroy]
  get 'uploads/index'
  get 'uploads/new'
  get 'uploads/create'
  get 'uploads/destroy'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  #root 'application#hello'
  root 'uploads#index'
end
