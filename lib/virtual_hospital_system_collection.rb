# Helper class that returns an array of all hospital systems and providers that
# are not part of systems
class VirtualHospitalSystemCollection
  class << self
    delegate :call, to: :new
  end

  def call
    systems_and_providers.sort_by(&:name)
  end

  private

  def systems_and_providers
    HospitalSystem.all + Provider.without_system
  end
end
