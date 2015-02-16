class AddOrganizationIdToOrphan < ActiveRecord::Migration
  def change
    add_column :orphans, :organization_id, :integer
    add_index :orphans, :organization_id
  end
end
