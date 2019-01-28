class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  http_basic_authenticate_with name:"zephyr", password:"strongpasswd", only: :admin
  def admin
    @users = User.all
  end
  
  def show
    @user = current_user
  end

  def new
    if logged_in?
      redirect_to items_path
      return
    end
    @user = User.new
  end

  def create
    if logged_in?
      redirect_to items_path
      return
    end
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "You have been successfully registered!"
      redirect_to items_path
    else
      flash.now[:danger] = "The following error(s) prohibited this user from being saved:\n\r ♣ " + @user.errors.full_messages.join(" ♣ ")
      render "new", status: :bad_request
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    user = User.find(current_user.id)
    if params[:change] == "details"
      status = user.update_attributes(user_params)
    elsif params[:change] == "password" && user.authenticate(params[:user][:current_password])
      status = user.update_attributes(user_params)
    end
    if status
      flash[:success] = "Successfully updated details."
      redirect_to current_user
    else
      @user = user
      if !user.authenticate(params[:user][:current_password])
        flash.now[:danger] = "The following error(s) prohibited this user from being saved:\n\r ♣ Invalid password, authentication failed "
      else
        flash.now[:danger] = "The following error(s) prohibited this user from being saved:\n\r ♣ " + @user.errors.full_messages.join(" ♣ ")
      end
      flash.now[:danger] ||= "Error! Please try again."
      render "edit", status: :bad_request
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      flash[:danger] = "Action prohibited! You cannot delete yourself!"
    else
      @user.destroy
      flash[:success] = "User " + @user.name  + " and the associated tasks and categories have been permanently deleted."
    end

    redirect_to admin_path

  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
