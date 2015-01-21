Rails.application.routes.draw do
  shallow do # we should always use shallow routes, internally at least
    mount Flip::Engine => '/flip'
    resource :status, only: :show

    namespace :dabo_admin do
      resources :hospitals
      resources :hospital_systems
    end
    resources :pristine_examples

    get 'measures', to: 'measures_root#show'
    get 'measures/*id', to: 'public_charts#show'
  end
end
