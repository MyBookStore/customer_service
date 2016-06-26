class UsersController < ApplicationController
  def create
    delete_if_user_exist
    @user = User.new(user_params)
    if @user.save!
      render :show, status: 201
    else
      render nothing: true, status: 422
    end
  end

  def delete_if_user_exist
    existing_user = User.find_by(params[:user][:id])
    if existing_user
      User.destroy(existing_user)
    end
  end

  def search
    @user = User.find_by(params[:user][:id])
    if @user
      render :show, status: 200
    else
      render nothing: true, status: 404
    end
  end


  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
