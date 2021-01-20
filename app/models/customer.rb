class Customer < ApplicationRecord
    belongs_to :user 
    has_many :appointments
    has_many :categories, through: :appointments 
    validates :first_name, :last_name, :email, :phone_number, presence: true 
    validates :first_name, :last_name, {:length => { :maximum => 12}}
    validates :first_name, :last_name, {:length => { :minimum => 2}}
    validates :email, uniqueness: true 
    validates :phone_number, {:length => { in: 9..10 }}
    validates :phone_number, numericality: { only_integer: true }
    #some email validation in regards to formatting
    #need to fix unique email on update/edit 

    def full_name 
        first_name.capitalize + " " + last_name.capitalize
    end

    
end
