class SessionsController < ApplicationController

    def home
    end

    def new 
        if logged_in?
            redirect_to appointments_path 
        end
    end

    def create  
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect_to appointments_path 
        else 
            flash[:message] = "Incorrect login information, please try again."
            redirect_to login_path 
        end
    end

    def facebook 
        @user = User.find_or_create_by(email: auth['info']['email']) do |u|
            u.first_name = auth['info']['name'].split(" ")[0]
            u.last_name = auth['info']['name'].split(" ")[1]
            u.email = auth['info']['email']
            u.password = SecureRandom.hex(10)
        end
        if @user.save 
            session[:user_id] = @user.id
            redirect_to appointments_path
        else 
            redirect_to root_path 
        end
    end


    def destroy 
        session.clear
        redirect_to root_path 
    end

     
    private
     
    def auth
        request.env['omniauth.auth']
    end


end

