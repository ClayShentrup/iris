Rails.application.routes.draw do
  mount Flip::Engine => '/flip'
  resource 'measures_home', only: [:show]
  resources :pristine_examples
end
