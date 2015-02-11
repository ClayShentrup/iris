# Helper class that returns an array of all hospital systems and hospitals that
# are not part of systems
class VirtualHospitalSystemCollection
  class << self
    delegate :call, to: :new
  end

  def call
    systems_and_hospitals.sort_by(&:name)
  end

  private

  def systems_and_hospitals
    HospitalSystem.all + Hospital.without_system
  end
end
