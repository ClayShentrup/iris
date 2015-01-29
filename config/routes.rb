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
    end
    resource :news_feed, only: :show, path: 'news'
    resources :pristine_examples

    resource :measures, only: :show, controller: :charts_root
    get 'measures/*id', to: 'public_charts#show'
  end
end
