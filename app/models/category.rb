class Category < ApplicationRecord
    belongs_to :user 
    has_many :appointments
    has_many :customers, through: :appointments 

end