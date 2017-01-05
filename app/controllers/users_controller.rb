class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    # @user = User.find_by(params[:id])
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      log_in @user
      flash[:success] = "Success my friend!"
      redirect_to user_url(@user)
      # redirect_to @user # this work as well #
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find_by(params[:id])
    @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])
   if @user.update_attributes(user_params)
     flash[:success] = "Profile updated"
     redirect_to @user
   else
     render 'edit'
   end
 end

  private

  def user_params
    params.require(:user).permit(:name , :email, :password,
                                 :password_confirmation)
  end

  # Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
        flash[:danger] = "Please log in my friend."
        redirect_to login_url
      end
  end
end
