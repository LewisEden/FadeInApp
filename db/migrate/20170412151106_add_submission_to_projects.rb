class AddSubmissionToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :submission, :string
  end
end
