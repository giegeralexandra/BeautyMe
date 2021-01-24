class CategoriesController < ApplicationController
    before_action :redirect_if_not_logged_in 
    before_action :user_can_only_view_own_information, only: [:show, :edit]
    before_action :assign_category, only: [:edit, :update, :show, :destroy, :appointments_index, :appointments, :customers_index, :customers]

    def index
        @categories = current_user.categories.all 
    end

    def new
        @category = Category.new
    end

    def create 
        @category = current_user.categories.build(category_params)
        if @category.save
            redirect_to category_path(@category)
        else 
            render :new
        end
    end

    def edit 
    end

    def update 
        if @category.update(category_params) 
            redirect_to category_path(@category)
        else 
            render :edit 
        end
    end

    def show 
    end

    def destroy 
        @category.appointments.destroy 
        @category.destroy
        redirect_to categories_path
    end

    def appointments_index 
        @appointment = @category.appointments 
        render template: 'appointments/index'
    end

    def appointments 
        @appointment= Appointment.find(params[:appointment_id])
        render template: 'appointments/show'
    end

    def customers_index 
        @customer = @category.customers
        render template: 'customers/index'
    end

    def customers 
        @customer = Customer.find(params[:customer_id])
        render template: 'customers/show'
    end

    private 

    def assign_category
        @category = Category.find_by(id: params[:id])
    end

    def category_params 
        params.require(:category).permit( :name, :user_id, :customer_id)
    end

    def user_can_only_view_own_information
        category = Category.find_by(id: params[:id])     
        if !!category
            unless category.user_id == current_user.id 
            flash[:error] = "Access Denied. User must be owner of category to view."
            redirect_to categories_path 
            end
        end
        if !category 
            flash[:error] = "Category does not exist."
            redirect_to categories_path 
        end
    end
            

end