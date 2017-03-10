class ChangeSynopsisTypeInProjects < ActiveRecord::Migration[5.0]
  def change
  	change_column :projects, :synopsis, :text
  end
end
