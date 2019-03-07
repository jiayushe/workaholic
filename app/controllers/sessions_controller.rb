class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    redirect_to items_path if logged_in?
  end

  def create
    if logged_in?
      redirect_to items_path
      return
    end
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "Welcome back to Workaholic!"
      redirect_to items_path
    else
      flash.now[:danger] = "Invalid username and/or password."
      render "new", status: :bad_request
    end
  end

  def destroy
    log_out
    flash[:success] = "You have been logged out."
    redirect_to login_path
  end
end
