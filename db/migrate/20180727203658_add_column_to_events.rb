class AddColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :venue, :string
    add_column :events, :seatgeek_id, :integer
  end
end
