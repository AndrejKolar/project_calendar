class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def index
      if current_user && current_user.admin?
        redirect_to :controller=>'users', :action => 'index'
      else
        redirect_to :controller=>'calendar', :action => 'index'
      end
  end
end
