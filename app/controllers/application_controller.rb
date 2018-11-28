class ApplicationController < ActionController::Base
  
  helper_method :current_user, :logged_in?

  def current_user
    # go to DB, look for user_id of 7, return the user with the id 7
    # get the entire user object for the user that is logged in right now
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # ||= is memoization --> prevents you from hitting the DB every time...
    # If there's already a current user, return that current user; otherwise, do a lookup for that user with that ID
  end

  def logged_in?
    # check if there's a current_user --> that would mean someone is logged in
    # adding !! makes anything a boolean; if there's a current_user this will return true
    !!current_user
  end

  def require_user
    # restrict actions based on if a user is logged in or not
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action."
      redirect_to root_path
    end
  end
end
