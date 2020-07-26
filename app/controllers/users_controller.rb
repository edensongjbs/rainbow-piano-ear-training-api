class UsersController < ApplicationController
    def create
        # byebug
        user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
        render json: user
    end
end
