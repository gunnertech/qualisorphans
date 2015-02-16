class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.string :username
      t.string :consumer_key
      t.string :consumer_secret
      t.string :access_token
      t.string :access_token_secret
      t.belongs_to :organization, index: true

      t.timestamps null: false
    end
    add_foreign_key :twitter_accounts, :organizations
  end
end
