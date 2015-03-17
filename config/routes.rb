require 'sidekiq'
require 'sidekiq/web'
require_relative '../lib/constraints/is_dabo_admin'

Rails.application.routes.draw do

  shallow do # we should always use shallow routes, internally at least
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions',
    }
    resource :status, only: :show
    resource :styleguide, only: :show if APP_CONFIG.styleguide_enabled

    authenticate :user do
      namespace :user_profiles do
        resource :admin, only: :show
        resource :info, only: :show
        resource :menu, only: :show
        resources :settings, only: :index
      end
      resources :news_items, only: :index
      resources :pristine_examples
      resources :data_categories, only: :index
      resources :provider_search_results, only: [:index, :show]
      resources :measure_search_results, only: :index

      # product-friendly aliases
      get :news, to: 'news_items#index'
      get :metrics, to: 'data_categories#index'
      get 'metrics/*id', to: 'public_charts#show'
      root 'news_items#index'
    end

    authenticate :user, Constraints::IsDaboAdmin do
      mount Flip::Engine => '/flip'
      mount Sidekiq::Web => '/sidekiq'

      namespace :dabo_admin do
        resources :accounts do
          resources :authorized_domains
        end
        resources :hospital_systems
        resources :providers
        resources :reports, only: :index
        resources :users
      end
    end
  end
end
