class User < ApplicationRecord
    has_many :customers
    has_many :appointments
    has_many :categories

    has_secure_password 

    validates :first_name, :last_name, {:length => { :maximum => 12, :minimum => 2}}
    validates_uniqueness_of :email, { case_sensitive: false }

    def full_name 
        first_name.capitalize + " " + last_name.capitalize 
    end

end