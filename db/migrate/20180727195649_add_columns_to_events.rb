class AddColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :category, :string
    add_column :events, :url, :string
    add_column :events, :price, :integer
    add_column :events, :lat, :string
    add_column :events, :long, :string
  end
end
