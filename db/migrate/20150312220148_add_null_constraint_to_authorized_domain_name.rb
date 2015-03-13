class AddNullConstraintToAuthorizedDomainName < ActiveRecord::Migration
  def change
    change_column_null(:authorized_domains, :name, false)
  end
end
