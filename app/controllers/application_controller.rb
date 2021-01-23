class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :upcoming_appointments, :appointment_time_view, :appointment_date_view, :appointment_date_time_view #gives access to methods in the views 
    
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
    
    def appointment_time_view(datetime)
        datetime.strftime('%I:%M%P')
    end
 
    def appointment_date_view(datetime)
        datetime.strftime("%A") + " " + datetime.strftime("%m/%d/%Y")
    end

    def appointment_date_time_view(datetime)
        appointment_time_view(datetime) + " " + appointment_date_view(datetime)
    end

end
