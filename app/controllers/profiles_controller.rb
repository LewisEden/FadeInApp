class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  	@projects = @user.projects.order('created_at Desc')
  end

  def edit
  end

  def update
    @user.tickets = 0
  	if @user.update(profile_params)
  		redirect_to profile_path(@user.user_name)
  	else
  		render :edit
  	end
  end

  private

  def profile_params
  	params.require(:user).permit(:avatar, :bio, :first_name, :last_name, :school)
  end

  def owned_profile
  	@user = User.find_by(user_name: params[:user_name])
  	unless current_user == @user
  		redirect_to root_path
  	end
  end

  def set_user
  	@user = User.find_by(user_name: params[:user_name])
  end
end
