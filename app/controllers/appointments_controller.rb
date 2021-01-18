class AppointmentsController < ApplicationController
    before_action :redirect_if_not_logged_in 

    def new 
        @appointment = Appointment.new 
    end

    def create 
        @appointment = Appointment.new(appointment_params)
        @appointment.user_id = session[:user_id]
        @appointment.customer_attributes(params[:appointment][:customer_attributes])
        @appointment.category_attributes(params[:appointment][:category_attributes])
        if @appointment.save 
            redirect_to appointment_path(@appointment)
        else
            render :new 
        end        
    end

    def edit 
    end

    def update
    end

    def show 
    end

    def destroy 
    end

    private 

    def appointment_params
        params.require(:appointment).permit(:id, :title, :date, :start_time, :end_time, :price, :customer_id, :category_id, :user_id, :customer_attributes => [:first_name, :last_name, :email, :phone_number, :user_id], :category_attributes => [:name, :user_id])
    end

end