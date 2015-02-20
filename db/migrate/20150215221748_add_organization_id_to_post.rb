class AddOrganizationIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :organization_id, :integer
    add_index :posts, :organization_id
  end
end
