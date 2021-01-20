class Category < ApplicationRecord
    belongs_to :user 
    has_many :appointments
    has_many :customers, through: :appointments 
    validates :name, presence: true 
    validates :name, uniqueness: true 
    validate :name {:length => { :maximum => 12}}
    validate :name {:length => { :minimum => 2}}


end