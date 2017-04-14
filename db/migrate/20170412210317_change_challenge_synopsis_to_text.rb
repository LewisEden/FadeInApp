class ChangeChallengeSynopsisToText < ActiveRecord::Migration[5.0]
  def change
    change_column :challenges, :synopsis, :text
  end
end
