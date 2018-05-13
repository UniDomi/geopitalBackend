Rails.application.routes.draw do
  get 'locations/index'
  get 'locations/details'
  get 'locations/coords'
  get 'locations/parse'
  get 'hospitals/coords'
  get 'hospitals/details'
  get 'hospitals/index'
  get 'hospitals/new'
  get 'hospitals/parse'
  get 'attribute_types/index'
  get 'attribute_types/new'
  get 'attribute_types/parse'
  get 'attribut_types/inex'
  get 'attribut_types/nw'
  get 'attribut_types/parse'
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
