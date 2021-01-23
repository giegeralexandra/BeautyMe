class CustomersController < ApplicationController
    before_action :user_can_only_view_own_information, only: [:show, :edit]
    before_action :assign_customer, only: [:show, :edit, :update, :destroy, :categories_index, :categories, :appointments_index, :appointments]
    
    def index
        @customers = current_user.customers.all 
    end

    def new
        @customer = Customer.new
    end

    def create 
        @customer = current_user.customers.build(customer_params)
        if @customer.save   
            redirect_to customer_path(@customer)
        else 
            render :new 
        end
    end

    def edit
    end

    def update
        if @customer.update(customer_params) 
            redirect_to customer_path(@customer)
        else 
            render :edit  
        end
    end

    def show 
    end


    def destroy 
        @customer.destroy 
        redirect_to customers_path 
    end

   def appointments_index 
        @appointments = @customer.appointments
        render template: 'appointments/index'
    end

    def appointments 
        @appointment = Appointment.find(params[:appointment_id])
        render template: 'appointments/show'
    end

    def categories_index 
        @categories = @customer.categories
        render template: 'categories/index'
    end

    def categories
        @category = Category.find(params[:category_id])
        render template: 'categories/show'
    end

    private 

    def customer_params 
        params.require(:customer).permit(:id, :first_name, :last_name, :email, :phone_number)
    end

    def user_can_only_view_own_information
        customer = Customer.find_by(id: params[:id])
        unless customer.user_id == current_user.id 
            flash[:error] = "Access Denied. User must be owner of customer to view."
            redirect_to customers_path 
        end
    end

    def assign_customer
        @customer = Customer.find_by(id: params[:id])
    end

end