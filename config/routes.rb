Rails.application.routes.draw do
  shallow do # we should always use shallow routes, internally at least
    mount Flip::Engine => '/flip'
    resource :measures_home, only: :show
    scope '/dabo_admin' do
      resources :systems
    end
    resources :pristine_examples

    # e.g. /measure_sources/cms/bundles
    resources :measure_sources, only: [] do
      resources :bundles, only: :index
    end

    resources :bundles, only: [] do
      # e.g. /bundles/value-based-purchasing/domains
      resources :domains, only: :index

      # e.g.
      # /bundles/readmission-reduction-program/bundle_measures
      # /bundles/readmission-reduction-program/bundle_measures/30-day-copd
      resources :bundle_measures, only: [:index, :show]
    end

    resources :domains, only: [] do
      # e.g.
      # /domains/hospital-acquired-infection/domain_measures
      # /domains/patient-safety-indicator/domain_measures/patient-safety-composite
      resources :domain_measures, only: [:index, :show]

      # e.g. /domains/outcome-of-care/categories
      resources :categories, only: :index
    end

    resources :categories, only: [] do
      # e.g.
      # /categories/mortality/category_measures
      # /categories/mortality/category_measures/30-day-mortality-ami
      resources :category_measures, only: [:index, :show]
    end
  end
end
