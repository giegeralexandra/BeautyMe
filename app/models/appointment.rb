class Appointment < ApplicationRecord
    belongs_to :customer
    belongs_to :user
    belongs_to :category 

    def customer_attributes=(customer_hash)
        if customer_hash[first_name].present? && customer_hash[last_name].present? && customer_hash[email].present? && customer_hash[phone_number].present?
            customer = Customer.find_or_create_by(email: customer_hash[:email])
            if !self.customer.present?
                self.customer.build(:customer => customer_hash)
            end
        end
    end

    def category_attributes=(category_hashes)
        category_hashes.each do |i, cat_attr|
            if cat_attr[name].present?
                category = Category.find_or_create_by(name: cat_attr[:name])
                if !self.category.present?
                    self.category.build(:category => category)
                end
            end
        end
    end
    

end
