Rails.application.routes.draw do
  devise_for :users
  shallow do # we should always use shallow routes, internally at least
    mount Flip::Engine => '/flip'
    resource :status, only: :show

    namespace :dabo_admin do
      resources :hospitals
      resources :hospital_systems
    end
    resources :pristine_examples

    resource :measures, only: :show, controller: :charts_root
    get 'measures/*id', to: 'public_charts#show'
  end
end
