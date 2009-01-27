class CreateAuthTables < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string :avatar
      t.string :given_name
      t.string :family_name
      t.string :identifier
      t.string :username
      t.string :email
      t.string :gender
      t.datetime :birthdate
      t.string :timezone
      t.string :home_country
      t.string :home_locality
      t.string :home_postal_code
      t.string :remember_token, :limit => 40
      t.datetime :remember_token_expires_at
      t.timestamps
    end
    add_index :users, :identifier, :unique => true
  end
  
  def self.down
    drop_table :users
  end
end