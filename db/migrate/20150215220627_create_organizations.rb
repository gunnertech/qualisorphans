class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :domain
      t.string :name
      t.string :url

      t.timestamps null: false
    end
    
    add_index :organizations, :domain, unique: true
  end
end
