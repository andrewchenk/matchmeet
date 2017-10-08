class AddScoresStrToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :scoresstr, :string
  end
end
