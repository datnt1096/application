class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.references :singer, foreign_key: true
      t.string :title
      t.text :lyrics
      t.string :song_url
      t.integer :view, default: 0

      t.timestamps
    end
  end
end
