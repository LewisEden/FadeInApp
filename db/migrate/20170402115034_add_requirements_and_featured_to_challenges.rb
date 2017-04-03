class AddRequirementsAndFeaturedToChallenges < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :featured, :boolean
    add_column :challenges, :requirements, :string
  end
end
