require 'sidekiq'
require 'sidekiq/web'

Rails.application.routes.draw do
  shallow do # we should always use shallow routes, internally at least
    devise_for :users
    resource :status, only: :show
    get '/styleguide', to: 'styleguides#index'

    namespace :dabo_admin do
      get '/', to: 'dabo_admins#index'
      resources :dabo_admins, only: :index
      resources :hospitals
      resources :hospital_systems
      resources :accounts
      resources :reports, only: :index
      resources :users
      resources :flip, only: [:index], controller: :features do
        resources :strategies, only: [:update, :destroy]
      end
    end

    mount Flip::Engine => '/dabo_admin/flip'
    resources :news_items, only: :index
    resources :pristine_examples
    resources :user_profiles
    resource :metrics, only: :show, controller: :charts_root
    get 'metrics/*id', to: 'public_charts#show'

    resources :hospital_search_results, only: :index

    # product-friendly aliases
    get :news, to: 'news_items#index'

    root 'news_items#index'
  end
end
