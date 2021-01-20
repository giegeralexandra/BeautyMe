class CategoriesController < ApplicationController

    def index
    end

    def new
        @category = Category.new 
        render :new 
    end

    def create 
        @category = current_user.categories.new(category_params)
        if @category.save 
            redirect_to category_path(@category)
        else 
            render :new
        end
    end

    def edit 
        @category = Category.find_by(id: params[:id])
    end

    def update 
        @category = Category.find_by(id: params[:id])
        if @category.update(category_params) 
            redirect_to category_path(@category)
        else 
            render :edit 
        end
    end

    def show 
        @category = Category.find_by(id: params[:id])
    end

    def destroy 
        @category = Category.find_by(id: params[:id])
        @category.destroy
        redirect_to categories_path
    end

    def appointments_index 
        @category = Category.find(params[:id])
        @appointment = @category.appointments 
        render template: 'appointments/index'
    end

    def appointments 
        @category = Category.find(params[:id])
        @appointment= Appointment.find(params[:appointment_id])
        render template: 'appointments/show'
    end

    def customer_index 
        @category = Category.find(params[:id])
        @customer = @category.customers
        render template: 'customers/index'
    end

    def customers 
        @category = Category.find(params[:id])
        @customer = Customer.find(params[:customer_id])
        render template: 'customer/show'
    end

    private 

    def category_params 
        params.require(:category).permit( :name, :user_id)
    end



end