class DatePlan < ApplicationRecord
  has_many :events
  has_many :restaurants
  belongs_to :user
end
