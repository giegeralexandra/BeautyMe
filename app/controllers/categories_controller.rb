class CategoriesController < ApplicationController

    def index
    end

    def new
        @category = Category.new 
    end

    def create 
        @category = Category.new(category_params)
        @category.user_id = session[:user_id]
        if @category.save 
            redirect_to category_path(@category)
        else 
            redirect_to new_category_path
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
            redirect_to edit_category_path(@category)
        end
    end

    def show 
        @category = Category.find_by(id: params[:id])
    end

    def destroy 
    end

    private 

    def category_params 
        params.require(:category).permit(:id, :name, :uder_id)
    end



end