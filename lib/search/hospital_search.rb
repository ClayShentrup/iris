require './app/models/hospital'

# Searches hospitals
module Search
  HospitalSearch = Struct.new(:query) do
    private_class_method :new

    def self.call(*args)
      new(*args).call
    end

    def call
      hospitals.map do |hospital|
        {
          id: hospital.id,
          name: hospital.name,
          city: hospital.city.titleize,
          state: hospital.state,
        }
      end
    end

    def hospitals
      Hospital.search_by_name(query).limit(10)
    end
  end
end
