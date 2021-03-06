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
			redirect_to new_sessions_path
		else
			render 'new'
		end
	end


protected

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
