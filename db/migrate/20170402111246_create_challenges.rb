class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.string :genre
      t.string :duration
      t.string :title
      t.string :synopsis
      t.integer :reward
      t.boolean :completed
      t.timestamps
    end
  end
end
