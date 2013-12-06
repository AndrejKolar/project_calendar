class UsersController < ApplicationController
  handles_sortable_columns

  def index
    @users = User.search(params[:search]).order(sortable_column_order).paginate(:per_page => 50, :page => params[:page])

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

def report
  @user = User.find(params[:user_id])
end

private
  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end
end
