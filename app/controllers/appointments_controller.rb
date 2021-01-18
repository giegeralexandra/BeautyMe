class AppointmentsController < ApplicationController
    before_action :redirect_if_not_logged_in 

    def new 
        @appointment = Appointment.new 
    end

    def create 
        @appointment = Appointment.new 
    end

    def edit 
        @appointment = Appointment.new(appointment_params)
        @appointment.customers_attributes=(params[:appointment][:customers_attributes])
        @appointment.categories_attributes=(params[:appointment][:categories_attributes])

        if @appointment.save 
            redirect_to appointment_path(@appointment)
        else 
            render :new 
        end
    end

    def update
    end

    def show 
    end

    def destroy 
    end

    private 

    def appointment_params
        params.require(:appointment).permit(:title, :date, :start_time, :end_time, :price, :customer_id, :category_id, :user_id, :customer_attributes => [:first_name, :last_name, :email, :phone_number, :user_id], :category_attributes => [:name, :user_id])
    end

end