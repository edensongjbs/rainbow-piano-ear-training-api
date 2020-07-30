class UsersController < ApplicationController

    skip_before_action :logged_in?, only: :create

    def index
        # byebug
        render json: @logged_in_user.user_object
    end

    def create
        # byebug
        user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], first_name: params[:first_name])
        
        if user.valid?
            user.save
            render json: {user_object: user.user_object, token: encode_token({user_id: user.id}) }
        else
            render json: {error: "Failed to create user"}, status: :not_acceptable
        end
    end

    def destroy
        @logged_in_user.user_levels.destroy_all
        @logged_in_user.destroy
        render json: {message: "User successfully Destroyed"}
    end

    # def current_user
    #     headers = request.headers["Authorization"]
    #     token = headers.split(" ")[1]

    #     begin
    #         user_id = JWT.decode(token, "AdaEarTraining")[0]["user_id"]
    #         user = User.find(user_id)
    #     rescue => exception
    #         user = nil
    #     end
    #     if user
    #         return user
    #     else
    #         render json: {error: "Please log in or sign up to play the games"}
    #     end
    # end
end
