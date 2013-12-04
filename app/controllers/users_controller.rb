class UsersController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
      format.js  { render :json => @users }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'dashboard', :action => 'index') }
      format.xml  { head :ok }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = "Profile updated."
    redirect_to @user
  else
    render 'edit'
  end
end

def show
end


  def user_params
    params.require(:user).permit(:user, :name, :email, :id)
  end


end
