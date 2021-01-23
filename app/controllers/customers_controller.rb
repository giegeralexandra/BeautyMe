class CustomersController < ApplicationController
    before_action :user_can_only_view_own_information, only: [:show, :edit]
    
    def index
        @customers = current_user.customers.all 
    end

    def new
        @customer = Customer.new
    end

    def create 
        @customer = current_user.customers.build(customer_params)
        if @customer.valid?
            @customer.save 
            redirect_to customer_path(@customer)
        else 
            render :new 
        end
    end

    def edit
        @customer = Customer.find_by(id: params[:id])
    end

    def update
        @customer = Customer.find_by(id: params[:id])
        if @customer.update(customer_params) 
            redirect_to customer_path(@customer)
        else 
            render :edit  
        end
    end

    def show 
        @customer = Customer.find_by(id: params[:id])
    end


    def destroy 
        @customer = Customer.find_by(id: params[:id])
        @customer.destroy 
        redirect_to customers_path 
    end

   def appointments_index 
        @customer = Customer.find(params[:id])
        @appointments = @customer.appointments
        render template: 'appointments/index'
    end

    def appointments 
        @customer = Customer.find(params[:id])
        @appointment = Appointment.find(params[:appointment_id])
        render template: 'appointments/show'
    end

    def categories_index 
        @customer = Customer.find(params[:customer_id])
        @categories = @customer.categories
        render template: 'categories/index'
    end

    def categories
        @customer = Customer.find(params[:customer_id])
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
            flash[:error] = "Access Denied. You must be owner of customer to view."
            redirect_to customers_path 
        end
    end

end