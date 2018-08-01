class ChangeDatePlanDate < ActiveRecord::Migration[5.2]
  def change
    change_table :date_plans do |t|
      t.change :date, :string
    end
  end
end
