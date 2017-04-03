class AddChallengeBooleanToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :challenge, :boolean
  end
end
