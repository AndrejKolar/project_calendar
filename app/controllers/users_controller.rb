class UsersController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'users', :action => 'index') }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = "Profile updated."
    respond_to do |format|
      format.html { redirect_to(:controller => 'users', :action => 'index') }
    end
  else
    render 'edit'
  end
end

  def user_params
    params.require(:user).permit(:user, :name, :email, :id)
  end
end
