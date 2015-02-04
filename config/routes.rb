Rails.application.routes.draw do
  shallow do # we should always use shallow routes, internally at least
    mount Flip::Engine => '/flip'
    devise_for :users
    resource :status, only: :show

    namespace :dabo_admin do
      resources :hospitals
      resources :hospital_systems
      resources :reports, only: :index
      resources :users
    end
    resources :news_items, only: :index
    resources :pristine_examples

    resource :metrics, only: :show, controller: :charts_root
    get 'metrics/*id', to: 'public_charts#show'

    # product-friendly aliases
    get :news, to: 'news_items#index'

    root 'news_items#index'
  end
end
