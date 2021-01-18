class Appointment < ApplicationRecord
    belongs_to :customer
    belongs_to :user
    belongs_to :category 

    def customer_attributes=(customer_hashes)
        customer_hashes.each do |i, cust_attr|
            if cust_attr[:first_name].present? && cust_attr[:last_name].present? && cust_attr[:email].present? && cust_attr[:phone_number].present?
                customer = Customer.find_or_create_by(email: cust_attr[:email])
                if !self.customer.present?
                    self.customer.build(:customer => customer)
                end
            end
        end
    end

    def category_attributes=(category_hashes)
        category_hashes.each do |i, cat_attr|
            if cat_attr[:name].present?
                category = Category.find_or_create_by(name: cat_attr[:name])
                if !self.category.present?
                    self.category.build(:category => category)
                end
            end
        end
    end
    

end
