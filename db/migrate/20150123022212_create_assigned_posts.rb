class CreateAssignedPosts < ActiveRecord::Migration
  def change
    create_table :assigned_posts do |t|
      t.belongs_to :orphan, index: true
      t.belongs_to :post, index: true

      t.timestamps null: false
    end
    add_foreign_key :assigned_posts, :orphans
    add_foreign_key :assigned_posts, :posts
  end
end
