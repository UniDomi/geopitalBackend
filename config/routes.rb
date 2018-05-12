Rails.application.routes.draw do
  get 'parsers/index'
  get 'parsers/details'
  get 'parsers/parse'
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
