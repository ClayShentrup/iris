Rails.application.routes.draw do
  root to: 'news_feeds#show'
  devise_scope :user do
    devise_for :users
    get 'sign_in', to: 'sessions#new'
    get 'sign_out', to: 'sessions#destroy'
  end

  shallow do # we should always use shallow routes, internally at least
    mount Flip::Engine => '/flip'
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

    get 'news', to: 'news_items#index'
  end
end
