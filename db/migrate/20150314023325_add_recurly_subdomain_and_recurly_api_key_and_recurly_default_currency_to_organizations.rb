class AddRecurlySubdomainAndRecurlyApiKeyAndRecurlyDefaultCurrencyToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :recurly_subdomain, :string
    add_column :organizations, :recurly_api_key, :string
    add_column :organizations, :recurly_default_currency, :string, null: false, default: 'USD'
  end
end
