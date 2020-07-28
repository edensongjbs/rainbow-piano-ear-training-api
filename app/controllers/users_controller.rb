class UsersController < ApplicationController

    skip_before_action :logged_in?, only: :create

    def create
        # byebug
        user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
        
        if user.valid?
            user.save
            render json: {email: user.email, token: encode_token({user_id: user.id}) }
        else
            render json: {error: "Failed to create user"}, status: :not_acceptable
        end
    end
end
