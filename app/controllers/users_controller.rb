class UsersController < ApplicationController 
  before_action :find_user, only: [:show, :edit, :groups, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :new]
  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def create
    @user = User.create( user_params )
    @user.save
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User successfully updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
      redirect_to root_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :admin)
  end

  def correct_user
    if user_signed_in?
	    redirect_to user_path(current_user) unless @current_user.id == @user.id || current_user.admin?
	else
	   redirect_to root_path
	end
  end
end
