class UsersController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
      format.js  { render :json => @users }
    end
  end

  # DELETE /user/1
  # DELETE /user/1.xml
  def destroy

    p "Called destroy for : " + params[:id].to_s

    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'dashboard', :action => 'index') }
      format.xml  { head :ok }
    end
  end
end
