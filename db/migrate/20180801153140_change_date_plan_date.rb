class ChangeDatePlanDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :date_plans, :date, :string
    add_column :date_plans, :date, :datetime
  end
end
