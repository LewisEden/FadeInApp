class AddCompletionToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :completed, :boolean
  end
end
