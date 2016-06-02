class UsersController < ApplicationController
    def new
      user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      user.save! if user.valid?
      render json: user
    end
  
    def index
      user = User.find_by(email: params[:email])
      user = user.authenticate(params[:password])
      user ?  (render json: user) : (render json: {})
    end
end
