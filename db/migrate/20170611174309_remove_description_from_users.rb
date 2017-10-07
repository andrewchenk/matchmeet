class RemoveDescriptionFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :description, :text
  end
end
