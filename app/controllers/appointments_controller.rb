class AppointmentsController < ApplicationController
    before_action :redirect_if_not_logged_in 

    def index
        @appointments = current_user.appointments 
    end

    def new 
        @appointment = Appointment.new 
    end

    def create 
        @appointment = current_user.appointments.build(appointment_params)
        #@appointment.customer.build(appointment_params[:customer_attributes])
        #@appointment.category.build(appointment_params[:category_attributes])
        #binding.pry 
        if @appointment.valid?
            @appointment.save 
            redirect_to appointment_path(@appointment)
        else 
            render :new 
        end       
    end

    def edit 
        @appointment = current_user.appointments.find_by(id: params[:id])
    end

    def update
        if @appointment = current_user.appointments.update(appointment_params)
            redirect_to appointment_path(@appointment)
        else 
            render :edit 
        end
    end

    def show 
        @appointment = current_user.appointments.find_by(id: params[:id])
    end

    def destroy
        @appointment = current_user.appointments.find_by(id: params[:id])
        @appointment.destroy 
        redirect_to appointments_path 
    end


    private 

    def appointment_params
        params.require(:appointment).permit(:name, :start_time, :end_time, :price, :customer_id, :category_id, :user_id, :customer_attributes => [:first_name, :last_name, :email, :phone_number, :user_id], :category_attributes => [:name, :user_id])
    end



end