class AddVfxToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :vfx, :integer
  end
end
