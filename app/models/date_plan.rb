class DatePlan < ApplicationRecord
  belongs_to :events
  belongs_to :restaurants
  belongs_to :user



end
