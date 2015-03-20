require './app/models/user'
require './app/models/account'
require './app/models/authorized_domain'

# Creates the association between a new user and an account based on
# the domain name in their email address
module Registrations
  FindAccountByEmailDomain = Struct.new(:email_address) do
    def self.call(*args)
      new(*args).call
    end

    def call
      authorized_domain.account if authorized_domain
    end

    private

    def authorized_domain
      @authorized_domain ||= AuthorizedDomain.find_by_name(email_domain)
    end

    def email_domain
      Mail::Address.new(email_address).domain
    end
  end
end
