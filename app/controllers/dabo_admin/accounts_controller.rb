module DaboAdmin
  # Dabo Admin Accounts Controller
  class AccountsController < ApplicationController
    helper_method :hospital_collection

    def system_hospitals
      render partial: 'hospital_select',
             action: 'hospital_select'
    end

    def hospital_collection
      virtual_system_id = params.fetch(:virtual_system_id, nil)
      if virtual_system_id
        virtual_system = GlobalID::Locator.locate virtual_system_id
        HospitalCollection.call(virtual_system)
      else
        []
      end
    end

    private

    def allowed_params
      params.require(:account)
        .permit(:virtual_system_id, :default_hospital_id)
    end

    def model_params
      {
        'virtual_system_id' => virtual_system_global_id.last,
        'virtual_system_type' => virtual_system_type,
      }
    end

    def virtual_system_type
      virtual_system_global_id.split('/').fourth
    end

    def virtual_system_global_id
      allowed_params.fetch(:virtual_system_id)
    end
  end
end
