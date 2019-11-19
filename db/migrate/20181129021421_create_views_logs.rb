class CreateViewsLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :views_logs do |t|
      t.references :song, foreign_key: true
      t.string :log_id

      t.timestamps
    end
  end
end
