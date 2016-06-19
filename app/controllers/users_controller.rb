class UsersController < ApplicationController
  def create
    # User.destroy_all # for test use only.
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201
    else
      render nothing: true, status: 422
    end
  end

  def search
    @user = User.find_by(params[:user])
    if @user
      render json: @user, status: 200
    else
      render nothing: true, status: 404
    end
  end


  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
