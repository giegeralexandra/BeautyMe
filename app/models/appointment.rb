class Appointment < ApplicationRecord
    belongs_to :customer
    belongs_to :user
    belongs_to :category 
end
