class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :role, default: 0
      t.string :encrypted_password, null: false, default: ""
      t.string :remember_token
      t.datetime :remember_created_at
      t.string :access_token
      t.string :image_url

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
