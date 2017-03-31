class AddProductionStageToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :prod_stage, :integer
  end
end
