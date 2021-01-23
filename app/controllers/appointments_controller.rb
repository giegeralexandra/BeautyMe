class AppointmentsController < ApplicationController
    before_action :redirect_if_not_logged_in 
    before_action :user_can_only_view_own_information, only: [:show, :edit]

    def index
            @appointments = current_user.appointments 
    end

    def new 
        if params[:category_id] && !Category.exists?(params[:category_id])
            redirect_to categories_path, alert: "Category not found"
        elsif params[:customer_id] && !Customer.exists?(params[:customer_id])
            redirect_to customers_path, alert: "Customer not found"
        else 
            @appointment = Appointment.new(category_id: params[:category_id], customer_id: params[:customer_id], user_id: current_user.id)
        end
    end

    def create 
        #binding.pry
        @appointment = current_user.appointments.build(appointment_params)
        #@appointment.customer = 
        #@appointment.customer = Customer.new(appointment_params[:customer_attributes])
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

    def upcoming 
        #fix 
        @appointments = Appointment.upcoming_appointments
        render :upcoming 
    end

    private 

    def appointment_params
        params.require(:appointment).permit(:name, :start_time, :end_time, :price, :customer_id, :category_id, :user_id, :customer_attributes => [:first_name, :last_name, :email, :phone_number, :user_id], :category_attributes => [:name, :user_id])
    end

    def user_can_only_view_own_information
        appointment = Appointment.find_by(id: params[:id])
        unless appointment.user_id == current_user.id 
            flash[:error] = "Cannot access appointment. You must be owner of appointment to access."
            redirect_to appointments_path 
        end
    end


end