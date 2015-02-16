class AddOrganizationIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :organization_id, :integer
    add_foreign_key :posts, :organization_id
  end
end
