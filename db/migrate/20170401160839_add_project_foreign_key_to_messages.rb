class AddProjectForeignKeyToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :project_id, :integer 
  end
end
