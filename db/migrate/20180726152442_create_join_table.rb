class CreateJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :restaurants, :categories do |t|
      t.index :restaurant_id 
      t.index :category_id
    end
  end
end
