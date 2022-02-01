class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to sales_path
    else
      respond_to do |format|
        format.html { redirect_to login_url(:notice => "Usuario y/ó contraseña incorrecta.")}
        format.json { head :no_content }
      end 
    end
  end

  def close
    session.delete(:user_id)
    redirect_to  '/pages/home'
  end

  def login
  end
end
