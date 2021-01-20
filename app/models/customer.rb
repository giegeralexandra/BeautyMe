class Customer < ApplicationRecord
    belongs_to :user 
    has_many :appointments
    has_many :categories, through: :appointments 
    validates :first_name, :last_name, :email, :phone_number, presence: true 
    validate :first_name, :last_name {:length => { :maximum => 12}}
    validate :first_name, :last_name {:length => { :minimum => 2}}
    validates :email, uniqueness: true 
    validate :phone_number {:length => { in: 9..10 }}
    validates :phone_number, numericality: { only_integer: true }
    #some email validation

    def validate()
end