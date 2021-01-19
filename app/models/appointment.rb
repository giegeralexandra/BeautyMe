class Appointment < ApplicationRecord
    belongs_to :customer
    belongs_to :user
    belongs_to :category 
    accepts_nested_attributes_for :customer, :category 

    #def customer_attributes=(attr)
       # if attr[:first_name] != ""
           # self.customer = self.user.customer.find_or_create_by(att) 
       # end
  #  end

    #def category_attributes=(category_hashes)
        #category_hashes.each do |i, cat_attr|
            #if cat_attr[name].present?
                #category = Category.find_or_create_by(name: cat_attr[:name])
                #if !self.category.present?
                 #   self.category.build(:category => category)
                #end
            #end
        #end
    #end
    

end
