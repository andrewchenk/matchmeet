class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :Users, :Image_Urls, :image_urls   
  end
end
