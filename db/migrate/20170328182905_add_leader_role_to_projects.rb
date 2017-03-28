class AddLeaderRoleToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :leader_role, :string
  end
end
