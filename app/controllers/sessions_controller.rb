class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to '/pages/home'
    else
        redirect_to '/login'
    end
  end

  def close
    session.delete(:user_id)
    redirect_to  '/pages/home'
  end

  def login
  end
end
