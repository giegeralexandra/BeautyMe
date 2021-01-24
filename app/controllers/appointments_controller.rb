class AppointmentsController < ApplicationController
    before_action :redirect_if_not_logged_in 
    before_action :user_can_only_view_own_information, only: [:show, :edit]
    before_action :assign_appointments
    before_action :assign_appointment, only: [:edit, :update, :show, :destroy]

    def index
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
        @appointment = current_user.appointments.build(appointment_params)
        if @appointment.save
            redirect_to appointment_path(@appointment)
        else 
            render :new 
        end       
    end

    def edit 
    end

    def update
        if @appointment.update(appointment_params)
            redirect_to appointment_path(@appointment)
        else 
            render :edit 
        end
    end

    def show 
    end

    def destroy
        @appointment.destroy 
        redirect_to appointments_path 
    end

    def upcoming 
    end

    private 

    def appointment_params
        params.require(:appointment).permit(:name, :start_time, :end_time, :price, :customer_id, :category_id, :user_id, :customer_attributes => [:first_name, :last_name, :email, :phone_number, :user_id], :category_attributes => [:name, :user_id])
    end

    def user_can_only_view_own_information
        appointment = Appointment.find_by(id: params[:id])
        if !!appointment 
            unless appointment.user_id == current_user.id
                flash[:error] = "Access Denied. User must be owner of appointment to view."
                redirect_to appointments_path 
            end
        end
        if !appointment
            flash[:error] = "Appointment does not exist."
            redirect_to appointments_path 
        end
    end

    def assign_appointment 
       @appointment = Appointment.find_by(id: params[:id])
    end

    def assign_appointments 
        @appointments = current_user.appointments 
    end

end