class CustomersController < ApplicationController
    def index
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

    def category_index 
        @customer = Customer.find(params[:id])
        @category = @customer.categories
        render template: 'categories/index'
    end

    def categories 
        @customer = Customer.find(params[:id])
        @category = Category.find(params[:category_id])
        render template: 'category/show'
    end

    private 

    def customer_params 
        params.require(:customer).permit(:id, :first_name, :last_name, :email, :phone_number)
    end

end