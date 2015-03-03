require 'sidekiq'
require 'sidekiq/web'
require_relative '../lib/constraints.rb'

Rails.application.routes.draw do
  shallow do # we should always use shallow routes, internally at least
    devise_for :users, controllers: { registrations: :registrations }
    resource :status, only: :show
    get :styleguide, to: 'styleguides#index'

    constraints Constraints::DaboAdmin do
      mount Flip::Engine => '/flip'
      mount Sidekiq::Web => '/sidekiq'

      namespace :dabo_admin do
        resources :hospitals
        resources :hospital_systems
        resources :accounts
        resources :reports, only: :index
        resources :users
      end
    end

    namespace :user_profiles do
      resource :admin, only: [:show]
      resource :info, only: [:show]
      resource :menu, only: [:show]
      resource :settings, only: [:show]
    end

    resources :news_items, only: :index
    resources :pristine_examples
    resource :metrics, only: :show, controller: :charts_root
    get 'metrics/*id', to: 'public_charts#show'

    resources :hospital_search_results, only: :index

    # product-friendly aliases
    get :news, to: 'news_items#index'

    resources :measure_search_results, only: :index

    root 'news_items#index'
  end
end
