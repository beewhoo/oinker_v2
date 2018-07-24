class Event < ApplicationRecord
    has_many :users, through: :date_plan
end
