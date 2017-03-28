class AddUserRoleToUserProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :user_projects, :user_role, :string
  end
end
