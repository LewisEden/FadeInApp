class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.text :bio
      t.string :role
      t.boolean :sent

      t.timestamps
    end
  end
end
