class AddHeaderUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :header_url, :string
  end
end
