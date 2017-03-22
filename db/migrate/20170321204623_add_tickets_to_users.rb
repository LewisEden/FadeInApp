class AddTicketsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tickets, :integer
  end
end
