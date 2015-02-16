class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :uuid
      t.belongs_to :user, index: true
      t.belongs_to :orphan, index: true

      t.timestamps null: false
    end
    add_foreign_key :subscriptions, :users
    add_foreign_key :subscriptions, :orphans
    add_index :subscriptions, :uuid, unique: true
  end
end
