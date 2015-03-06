require './app/models/provider'
require './app/models/hospital_system'

module Providers
  # Encapsulates the information needed to show the options to compare one
  # hospital against others in the same city, state, system or across
  # the country
  class ProviderComparePresenter
    attr_reader :provider
    delegate :name,
             :city_and_state,
             :state,
             to: :provider,
             prefix: true

    delegate :hospital_system_name, to: :provider

    def initialize(provider)
      @provider = provider
    end

    def providers_in_city_count
      Provider.in_same_city(provider).count
    end

    def providers_in_state_count
      Provider.in_same_state(provider).count
    end

    def hospital_system?
      hospital_system.present?
    end

    def providers_in_system_count
      hospital_system.providers_count
    end

    def providers_count
      Provider.count
    end

    private

    def hospital_system
      provider.hospital_system
    end
  end
end
