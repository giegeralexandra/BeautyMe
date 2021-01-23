class Customer < ApplicationRecord
    belongs_to :user 
    has_many :appointments
    has_many :categories, through: :appointments 

    validates :first_name, :last_name, :email, :phone_number, presence: true 
    validates :first_name, :last_name, {:length => { :maximum => 12, :minimum => 2}}
    validates :email, uniqueness: { case_sensitive: false }
    validates :phone_number, {:length => {is: 10}}
    validates :phone_number, numericality: { only_integer: true }
    
    def full_name 
        first_name.capitalize + " " + last_name.capitalize
    end 

end
