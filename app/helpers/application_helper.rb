module ApplicationHelper
	# current_user sets up who is logging in. use :current_user when we need to access something throughout the app. use @current_user when defining for a specific section of code. or/= means
  def current_user
    @current_user ||= session[:remember_token] && User.find(session[:remember_token])
  end

  def authenticate_user
    if !current_user
      redirect_to new_sessions_path
    end
  end
end
