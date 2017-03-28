class SetSentToFalseDefault < ActiveRecord::Migration[5.0]
  def change
    change_column :requests, :sent, :boolean, default: false
  end
end
