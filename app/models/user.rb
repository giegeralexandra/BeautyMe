class User < ApplicationRecord
    has_many :customers
    has_many :appointments
    has_many :categories
    has_secure_password #authenticate, validate password, password confirmation 
end