Rails.application.routes.draw do
  shallow do # we should always use shallow routes, internally at least
    mount Flip::Engine => '/flip'
    resource :measures_home, only: :show
    namespace :dabo_admin do
      resources :hospitals
      resources :hospital_systems
    end
    resources :pristine_examples

    # e.g. /measure_sources/cms/bundles
    resources :measure_sources, only: nil do
      resources :bundles, only: :index
    end

    resources :bundles, only: nil do
      # e.g. /bundles/value-based-purchasing/domains
      resources :domains, only: :index

      # e.g.
      # /bundles/readmission-reduction-program/bundle_measures
      # /bundle_measures/30-day-copd
      resources :bundle_measures, only: [:index, :show]
    end

    resources :domains, only: nil do
      # e.g.
      # /domains/hospital-acquired-infection/domain_measures
      # /domain_measures/patient-safety-composite
      resources :domain_measures, only: [:index, :show]

      # e.g. /domains/outcome-of-care/categories
      resources :categories, only: [:index, :show]
    end

    resources :categories, only: nil do
      # e.g.
      # /categories/mortality/category_measures
      # /category_measures/30-day-mortality-ami
      resources :category_measures, only: [:index, :show]
    end
  end

  # Product-friendly route aliases

  scope 'metrics/cms' do
    # /metrics/cms/value-based-purchasing/outcome-of-care/30-day-mortality-ami
    get '/value-based-purchasing/outcome-of-care/30-day-mortality-ami',
        to: 'category_measures#show',
        defaults: {
          category_measure_id: '30-day-mortality-ami',
        }

    # /metrics/cms/value-based-purchasing/outcome-of-care/30-day-mortality-heart-failure
    get '/value-based-purchasing/outcome-of-care/30-day-mortality-heart-failure',
        to: 'category_measures#show',
        defaults: {
          category_measure_id: '30-day-mortality-heart-failure',
        }

    # /metrics/cms/value-based-purchasing/outcome-of-care/30-day-mortality-pneumonia
    get '/value-based-purchasing/outcome-of-care/30-day-mortality-pneumonia',
        to: 'category_measures#show',
        defaults: {
          category_measure_id: '30-day-mortality-pneumonia',
        }
  end
end
