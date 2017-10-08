class AddScoreToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :score, :float
  end
end
