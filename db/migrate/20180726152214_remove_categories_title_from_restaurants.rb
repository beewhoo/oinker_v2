class RemoveCategoriesTitleFromRestaurants < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :categories_title, :text
  end
end
