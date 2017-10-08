class AddImageUrlsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :Image_Urls, :string
  end
end
