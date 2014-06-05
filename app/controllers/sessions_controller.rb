
class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by_email(params[:session][:email])

		if @user && @user.authenticate(params[:session][:password])
		  session[:remember_token] = @user.id
		  @current_user = @user
		  flash[:success] = "Welcome!"
		  redirect_to root_path
		else
		  flash[:error] = "Invalid email/password combination"
		  render 'new'
		end
	end

	def destroy
		session.delete(:remember_token)
		redirect_to root_path
	end

end

