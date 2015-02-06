module DaboAdmin
  # Dabo Admin Accounts Controller
  class AccountsController < ApplicationController
    before_action EnsureAdminFilter

    def system_hospitals
      hospital_collection = HospitalCollection.call(virtual_system)

      render partial: 'hospital_select',
             action: 'hospital_select',
             locals: { hospital_collection: hospital_collection }
    end

    def create
      @account = Account.new(allowed_params)
      @account.virtual_system = virtual_system
      @account.users = account_users

      flash_success_message('created') if @account.save
      respond_with :dabo_admin, @account
    end

    def edit
      super
      @account.virtual_system_gid = @account.virtual_system.to_global_id.to_s
    end

    def update
      @account = saved_model.tap do |acc|
        acc.assign_attributes(allowed_params)
        acc.virtual_system = virtual_system
        acc.users = account_users
      end

      flash_success_message('updated') if @account.save
      respond_with :dabo_admin, @account
    end

    private

    def allowed_params
      params.require(:account)
        .permit(:virtual_system_gid, :default_hospital_id, user_ids: [])
    end

    def account_users
      user_ids = params.fetch(:account).fetch(:user_ids).reject(&:blank?)
      User.find user_ids
    end

    def virtual_system
      GlobalID::Locator.locate virtual_system_gid if virtual_system_gid
    end

    def virtual_system_gid
      allowed_params.fetch(:virtual_system_gid, nil)
    end
  end
end
