class AddHeaderUrlToChallenges < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :header_url, :string
  end
end
