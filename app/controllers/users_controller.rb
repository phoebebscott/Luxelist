class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "You have successfully signed up!"
			redirect_to root_path
		else
			redirect_to root_path
		end
	end


protected

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
