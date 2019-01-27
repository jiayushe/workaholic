class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :require_login

  private
    helper_method :require_login
    def require_login
      if !logged_in?
        flash[:danger] = "You need to log in first!"
        redirect_to login_path
      end
    end
end
