class CategoriesController < ApplicationController
    before_action :user_can_only_view_own_information, only: [:show, :edit]

    def index
        @categories = current_user.categories.all 
    end

    def new
        @category = Category.new
        render :new 
    end

    def create 
        @category = current_user.categories.build(category_params)
        if @category.valid?
            @category.save
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

    def customers_index 
        @category = Category.find(params[:id])
        @customer = @category.customers
        render template: 'customers/index'
    end

    def customers 
        @category = Category.find(params[:id])
        @customer = Customer.find(params[:customer_id])
        render template: 'customers/show'
    end

    private 

    def category_params 
        params.require(:category).permit( :name, :user_id, :customer_id)
    end

    def user_can_only_view_own_information
        category = Category.find_by(id: params[:id])
        #binding.pry
        unless category.user_id == current_user.id 
            flash[:error] = "Cannot access category. You must be owner of category to access."
            redirect_to categories_path 
        end
    end



end