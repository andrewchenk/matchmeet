class AddAuthorToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :author, :string
  end
end
