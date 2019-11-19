class CreateGenersSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :geners_songs do |t|
      t.references :genre, foreign_key: true
      t.references :song, foreign_key: true

      t.timestamps
    end
  end
end
