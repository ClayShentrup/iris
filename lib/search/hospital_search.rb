# Searches hospitals
module Search
  HospitalSearch = Struct.new(:query) do
    def self.call(*args)
      new(*args).call
    end

    def call
      format_hospitals Hospital.search_by_name(query).limit(10)
    end

    private

    def format_hospitals(hospitals)
      hospitals.map do |hospital|
        {
          id: hospital.id,
          name: hospital.name.titleize,
          city: hospital.city.titleize,
          state: hospital.state,
        }
      end
    end
  end
end
