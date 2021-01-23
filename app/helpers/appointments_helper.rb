module AppointmentsHelper

    def duration(appointment)
        time_diff = (appointment.end_time - appointment.start_time)
        hours = (time_diff / 1.hour).to_i 
        minutes = ((time_diff / 1.minute) - (hours*60)).to_i
        hours.to_s + " hours " + minutes.to_s + " minutes"
    end

    def time(appointment)
        appointment.start_time.strftime('%I:%M%P')
    end
 
    def date(appointment)
        appointment.start_time.strftime("%A") + " " + appointment.start_time.strftime("%m/%d/%Y")
    end

    def date_time(appointment)
        date(appointment) + " " + time(appointment)
    end

    def price(appointment)
        number_to_currency(appointment.price)
    end

    def appointment_name(appointment)
        appointment.name.capitalize 
    end

end
