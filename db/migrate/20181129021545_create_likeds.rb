class CreateLikeds < ActiveRecord::Migration[5.2]
  def change
    create_table :likeds do |t|
      t.references :user, index: true
      t.references :song, index: true

      t.timestamps
    end
  end
end
