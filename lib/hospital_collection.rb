# Class that gets the associated hospitals out of a system, if it has any
class HospitalCollection
  def self.call(virtual_system)
    if virtual_system.respond_to? :hospitals
      virtual_system.hospitals
    else
      [virtual_system]
    end
  end
end
