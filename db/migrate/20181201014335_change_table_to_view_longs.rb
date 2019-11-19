class ChangeTableToViewLongs < ActiveRecord::Migration[5.2]
  def change
    rename_table :views_logs, :view_logs
  end
end
