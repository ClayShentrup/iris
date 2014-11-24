require 'delegate'

module ControllerFilters
  class EnsureJsonRequest < SimpleDelegator
    def self.before(controller)
      new(controller).call
    end

    def call
      return if format == 'json' || accepts_json?
      render nothing: true, status: :not_acceptable
    end

    def format
      params.fetch(:format, nil)
    end

    def accepts_json?
      request.headers.fetch(:accept, nil) =~ /json/
    end
  end
end
