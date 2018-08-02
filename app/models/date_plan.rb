class DatePlan < ApplicationRecord
  belongs_to :event
  belongs_to :restaurant
  belongs_to :user

end
