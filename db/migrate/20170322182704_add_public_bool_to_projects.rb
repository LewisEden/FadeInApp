class AddPublicBoolToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :public, :boolean
  end
end
