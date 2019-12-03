class CreateBuySongs < ActiveRecord::Migration[5.2]
  def change
    create_table :buy_songs do |t|
      t.references :user, foriegn_key: true
      t.references :song, foriegn_key: true

      t.timestamps
    end
  end
end
