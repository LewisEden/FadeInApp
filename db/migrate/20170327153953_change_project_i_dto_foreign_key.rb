class ChangeProjectIDtoForeignKey < ActiveRecord::Migration[5.0]
  def change
    change_column :requests, :project_id, :integer
  end
end
