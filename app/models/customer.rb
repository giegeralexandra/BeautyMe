class Customer < ApplicationRecord
    belongs_to :user 
    has_many :appointments
    has_many :categories, through :appointments 
end