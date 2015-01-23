class CreateOrphans < ActiveRecord::Migration
  def change
    create_table :orphans do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
