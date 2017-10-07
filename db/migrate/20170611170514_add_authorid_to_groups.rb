class AddAuthoridToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :author_id, :int
  end
end
