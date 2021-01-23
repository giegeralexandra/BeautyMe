class User < ApplicationRecord
    has_many :customers
    has_many :appointments
    has_many :categories

    has_secure_password 

    validates_uniqueness_of :email { case_sensitive: false }
end