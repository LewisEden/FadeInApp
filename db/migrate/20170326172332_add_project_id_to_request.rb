class AddProjectIdToRequest < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :project, foreign_key: true
  end
end
