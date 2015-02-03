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
        .permit(:virtual_system_id, :default_hospital_id, users: [:id])
    end

    def model_params
      {
        'virtual_system_id' => virtual_system_gid.model_id,
        'virtual_system_type' => virtual_system_gid.model_name,
        'default_hospital_id' => params.fetch(:account)
          .fetch(:default_hospital_id),
        'users' => account_users,
      }
    end

    def account_users
      if params.fetch(:account).fetch(:users, nil)
        User.find(params.fetch(:account).fetch(:users))
      else
        []
      end
    end

    def virtual_system_gid
      GlobalID.new(allowed_params.fetch(:virtual_system_id))
    end
  end
end
