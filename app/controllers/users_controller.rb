class UsersController < ApplicationController
    def new
      binding.pry
      user = User.new(name: params[:user][:name], email: params[:user][:email],
                      password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      user.save!
    end


end
