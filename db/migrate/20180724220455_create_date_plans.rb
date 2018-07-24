class CreateDatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :date_plans do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.integer :event_id
      t.datetime :date

      t.timestamps
    end
  end
end
