class UsersController < ApplicationController
    before_action :assign_user, only: [:show, :edit, :update]


    def new 
        if logged_in?
            redirect_to appointments_path 
        else
            @user = User.new
        end 
    end

    def create 
        @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        else 
            render :new 
        end
    end

    def show
    end

    def edit 
    end

    def update
        if @user.update(user_params)
            redirect_to user_path(@user)
        else 
            render :edit
        end
    end

    private 

    def user_params
        params.require(:user).permit(:id, :first_name, :last_name, :email, :password, :password_confirmation)
    end

    def assign_user 
        @user = current_user 
    end


end