class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :tweet_id_str
      t.string :body
      t.string :photo_url
      t.datetime :tweet_created_at

      t.timestamps null: false
    end

    add_index :posts, :tweet_id_str, unique: true
  end
end
