class AddPreferredRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pref_role, :string
  end
end
