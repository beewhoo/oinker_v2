class AddColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :venue, :string
    add_column :events, :api_id, :integer, :limit => 5 
    add_column :events, :image_url, :string

  end
end
