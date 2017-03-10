class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :genre
      t.string :duration
      t.string :title
      t.string :synopsis
      t.integer :director
      t.integer :writer
      t.integer :actor
      t.integer :editor
      t.integer :composer
      t.integer :cinematographer
      t.integer :makeup

      t.timestamps
    end
  end
end
