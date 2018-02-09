module SessionsHelper
  # Logs in the given user.
  def log_in(user)
  	flash[:success] = "Te revoila enfin !"
  	session[:user_id] = user.id
  end

  # Returns the user corresponding to the remember token cookie
  def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
  	!current_user.nil?
  end

  # Logs out the current user.
  def log_out
  	session.delete(:user_id)
  	@current_user = nil
  end
end
