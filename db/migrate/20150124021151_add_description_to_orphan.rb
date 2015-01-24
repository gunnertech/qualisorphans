class AddDescriptionToOrphan < ActiveRecord::Migration
  def change
    add_column :orphans, :description, :text
  end
end
