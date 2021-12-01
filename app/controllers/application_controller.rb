class ApplicationController < ActionController::Base


    # this helper method has been moved from the application_helper 
    #because  the current user  the user controller could not see the current user variable 


    helper_method :current_user, :logged_in?  # this needs because the views should see the current user variable
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        # if we have no current_user instance varible , only then query the database
    end

    def logged_in?
        !!current_user  # turns the current user variable to boolean
        #if nil then false
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        end
    end



end
