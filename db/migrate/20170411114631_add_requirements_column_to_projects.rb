class AddRequirementsColumnToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :r_director, :string
    add_column :projects, :r_writer, :string
    add_column :projects, :r_actor, :string
    add_column :projects, :r_editor, :string
    add_column :projects, :r_composer, :string
    add_column :projects, :r_makeup, :string
    add_column :projects, :r_cinematographer, :string
    add_column :projects, :r_vfx, :string
  end
end
