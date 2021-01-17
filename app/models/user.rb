class User < ApplicationRecord
    has_many :customers
    has_many :appointments
    has_many :categories
end