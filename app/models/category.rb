class Category < ApplicationRecord
    belongs_to :user 
    has_many :appointments
    has_many :customers, through: :appointments 
    validates :name, presence: true 
    validates :name, uniqueness: { case_sensitive: false }
    validates :name, {:length => { :maximum => 12}}
    validates :name, {:length => { :minimum => 2}}



end