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

    private 

    def customer_params 
        params.require(:customer).permit(:id, :first_name, :last_name, :email, :phone_number)
    end

end