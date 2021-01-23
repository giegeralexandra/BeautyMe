class Appointment < ApplicationRecord
    belongs_to :customer
    belongs_to :user
    belongs_to :category 

    accepts_nested_attributes_for :customer
    accepts_nested_attributes_for :category

    validates :name, :start_time, :end_time, :price, :customer_id, :category_id, presence: true 
    validates :name, {:length => { :maximum => 20, :minimum => 2}}
    validate :appointment_date_cannot_be_in_the_past, :appointment_end_time_cannot_be_before_start_time, :no_appointments_overlap
    
    scope :upcoming_appointments, -> {where("start_time > ? AND start_time < ?", Time.now, Time.now + 7.days)}
    scope :future_appointments, -> {where("start_time > ?", Time.now ).order('start_time asc')}
    
    def duration
        time_diff = (end_time - start_time)
        hours = (time_diff / 1.hour).to_i 
        minutes = ((time_diff / 1.minute) - (hours*60)).to_i
        hours.to_s + " hours " + minutes.to_s + " minutes"
    end

    #nested form methods 

    def customer_attributes=(attr)
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


    #validations 

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

    def no_appointments_overlap
        Appointment.all.each do |appointment|
            if appointment.start_time < self.end_time && self.start_time < appointment.end_time
                errors.add(:start_time, "conflicts with other appointments")
            end
        end
    end

end
