class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  # GET /approved_users
  # GET /approved_users.json
  def index
    @users = User.all
  end

  # GET /approved_users/1
  # GET /approved_users/1.json
  def show
  end

  def destroy
    user = User.find(params[:id])
    if user == current_user
      redirect_to users_path, :notice => "Can't delete yourself."
    else
      user.destroy
      redirect_to users_path, :notice => 'User deleted.'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def approved_user_params
    params.require(:user).permit(:name, :email, :role)
  end

end