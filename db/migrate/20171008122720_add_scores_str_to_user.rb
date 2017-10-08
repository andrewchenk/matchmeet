class AddScoresStrToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :scoresstr, :string
  end
end
