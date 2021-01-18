class CustomersController < ApplicationController
    def index
    end

    def new
        @customer = Customer.new 
    end

    def create 
        @customer = Customer.new(customer_params)
        @customer.user_id = session[:user_id]
        if @customer.save 
            redirect_to customer_path(@customer)
        else 
            redirect_to new_customer_path 
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
            redirect_to edit_customer_path(@customer) 
        end
    end

    def show 
        @customer = Customer.find_by(id: params[:id])
    end


    def destory 
        @customer = Customer.find_by(id: params[:id])
        @customer.destroy 
    end

    private 

    def customer_params 
        params.require(:customer).permit(:id, :first_name, :last_name, :email, :phone_number)
    end

end