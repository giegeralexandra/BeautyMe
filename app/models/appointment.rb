class Appointment < ApplicationRecord
    belongs_to :customer
    belongs_to :user
    belongs_to :category 
    accepts_nested_attributes_for :customer
    accepts_nested_attributes_for :category
    validates :name, :start_time, :end_time, :price, :customer_id, :category_id, presence: true 
    validates :name, {:length => { :maximum => 20}}
    validates :name, {:length => { :minimum => 2}}
    validate :appointment_date_cannot_be_in_the_past, :appointment_end_time_cannot_be_before_start_time
    scope :upcoming_appointments, -> {where("start_time > ? AND start_time < ?", Time.now, Time.now + 7.days)}

    def customer_attributes=(attr)
        #check to see if it will work if any other fields are blank
        if attr[:first_name] != ""
            customer = Customer.find_or_create_by(first_name: attr[:first_name], last_name: attr[:last_name], email: attr[:email], phone_number: attr[:phone_number], user_id: self.user_id) 
            self.customer_id = customer.id
        end
    end

    def category_attributes=(attr)
        if attr[:name] != ""
            category = Category.find_or_create_by(name: attr[:name], user_id: self.user_id) 
            self.category_id = category.id
        end
    end

    def appointment_date_cannot_be_in_the_past
        if start_time.present? && start_time < Date.today
          errors.add(:date, "can't be in the past")
        end
    end

    def appointment_end_time_cannot_be_before_start_time
        if start_time.present? && end_time.present? && end_time < start_time 
            errors.add(:end_time, "can't be before start time")
        end
    end

    #def appointments_must_not_overlap
       # return if self
                  #  .class
                   # .where.not(id: id)
                   # .where('start_date < ? AND end_date > ?', end_date, start_date)
                   # .none?
      
       # errors.add(:base, 'Overlapping reservation exists')
   # end

    def duration
        time_diff = (end_time - start_time)
        hours = (time_diff / 1.hour).to_i 
        minutes = ((time_diff / 1.minute) - (hours*60)).to_i
        hours.to_s + " hours " + minutes.to_s + " minutes"
    end

    def start_time_view
        start_time.strftime('%I:%M %P')
    end

    #def end_time_view
        #"end_time_view"
    #end

    def date_view
        start_time.strftime("%A") + " " + start_time.strftime("%m/%d/%Y")
    end

    #def self.costs_more_than(amount)
        #where("price > ?", amount)
      #end   

end
