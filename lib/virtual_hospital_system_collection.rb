# Helper class that returns an array of all hospital systems and hospitals that
# are not part of systems
class VirtualHospitalSystemCollection
  def self.call
    HospitalSystem.all + Hospital.without_system
  end
end
