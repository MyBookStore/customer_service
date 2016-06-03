class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render 'show', status: 201
    else
      render nothing: true, status: 422
    end
  end

  def search
    binding.pry
    @user = User.find_by(params[:user])
    if @user
      render 'show', status: 200
    else
      render nothing: true, status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
