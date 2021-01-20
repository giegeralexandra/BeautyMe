class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :upcoming_appointments #gives access to methods in the views 

    private 

    def current_user 
        @current_user ||= User.find_by(id: session[:user_id]) #if session[:user_id]
    end

    def logged_in?
        !!session[:user_id]
    end

    def redirect_if_not_logged_in 
        redirect_to root_path if !logged_in?
    end

    #need to put this in helper probably 
    def upcoming_appointments 
        upcoming_appointments = []
        current_user.appointments.each do |appt|
             if (appt.date < (Time.zone.now + 7.days)) && (appt.date > Time.zone.now) 
                upcoming_appointments << appt 
             end
        end
        upcoming_appointments 
    end

end
