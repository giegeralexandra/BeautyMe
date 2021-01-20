class Appointment < ApplicationRecord
    belongs_to :customer
    belongs_to :user
    belongs_to :category 
    accepts_nested_attributes_for :customer, :category 
    validates :title, :date, :start_time, :end_time, :price, :customer_id, :category_id, presence: true 
    #validates :price, numericality: { only_integer: true }
    validates :title, {:length => { :maximum => 20}}
    validates :title, {:length => { :minimum => 2}}
    validate :appointment_date_cannot_be_in_the_past, :appointment_end_time_cannot_be_before_start_time

    def appointment_date_cannot_be_in_the_past
        if date.present? && date < Date.today
          errors.add(:date, "can't be in the past")
        end
    end

    def appointment_end_time_cannot_be_before_start_time
        if start_time.present? && end_time.present? && end_time < start_time 
            errors.add(:end_time, "can't be before start time")
        end
    end


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
