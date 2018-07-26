class ChangeAddressTypeForRestaurants < ActiveRecord::Migration[5.2]
  def change

    remove_column :restaurants, :address
    add_column :restaurants, :address, :string 
  end
end
