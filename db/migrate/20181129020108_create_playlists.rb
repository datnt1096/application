class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.string :img_url

      t.timestamps
    end
    add_index :playlists, [:user_id, :created_at]
  end
end
