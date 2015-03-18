module DaboAdmin
  # Controller for authorized domains associated with accounts
  class AuthorizedDomainsController < ApplicationController
    def index
      @account = account
      @authorized_domains = @account.authorized_domains
    end

    def new
      @authorized_domain = AuthorizedDomain.new
      @account = account
    end

    def create
      @authorized_domain = AuthorizedDomain.new(model_params)
      @account = account
      @authorized_domain.account = @account
      flash_success_message('created') if @authorized_domain.save
      respond_with :dabo_admin, @authorized_domain
    end

    def destroy
      authorized_domain = AuthorizedDomain.find(params.require(:id))
      account = authorized_domain.account
      flash_success_message('deleted') if authorized_domain.destroy
      respond_with :dabo_admin, account, authorized_domain
    end

    private

    def model_params
      params.require(:authorized_domain).permit(:name)
    end

    def account
      Account.find(params.fetch(:account_id))
    end
  end
end
