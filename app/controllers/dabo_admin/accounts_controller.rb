module DaboAdmin
  # Dabo Admin Accounts Controller
  class AccountsController < ApplicationController
    private

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
      params.require(:account)
        .permit(:virtual_system_id).fetch(:virtual_system_id)
    end
  end
end
