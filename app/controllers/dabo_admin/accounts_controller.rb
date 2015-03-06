module DaboAdmin
  # Dabo Admin Accounts Controller
  class AccountsController < ApplicationController
    def new
      super
      show_providers_for_selected_system if request.xhr?
    end

    def create
      @account = Account.new(allowed_params)
      @account.virtual_system = virtual_system
      @account.users = account_users

      flash_and_respond('created')
    end

    def edit
      if request.xhr?
        show_providers_for_selected_system
      else
        super
        @account.virtual_system_gid = @account.virtual_system.to_global_id.to_s
        @provider_collection = @account.virtual_system.providers
      end
    end

    def update
      @account = saved_model.tap do |acct|
        acct.assign_attributes(allowed_params)
        acct.virtual_system = virtual_system
        acct.users = account_users
      end

      flash_and_respond('updated')
    end

    private

    def flash_and_respond(message)
      flash_success_message(message) if @account.save
      respond_with :dabo_admin, @account
    end

    def show_providers_for_selected_system
      render partial: 'provider_select',
             locals: {
               selected_default_provider_id: nil,
               provider_collection: virtual_system.providers,
             }
    end

    def allowed_params
      params.require(:account)
        .permit(:virtual_system_gid, :default_provider_id, user_ids: [])
    end

    def account_users
      user_ids = params.fetch(:account).fetch(:user_ids).reject(&:blank?)
      User.find user_ids
    end

    def virtual_system
      GlobalID::Locator.locate virtual_system_gid
    end

    def virtual_system_gid
      allowed_params.fetch(:virtual_system_gid, nil)
    end
  end
end
