class CreateOrphans < ActiveRecord::Migration
  def change
    create_table :orphans do |t|
      t.string :first_name
      t.string :last_name
      t.string :hashtag

      t.timestamps null: false
    end

    add_index :orphans, :hashtag, unique: true
  end
end
