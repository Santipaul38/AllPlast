class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if User.count <= 1
      @user = User.create(params.require(:user).permit(:username,        
      :password))
      session[:user_id] = @user.id
      redirect_to sales_path
    else
      respond_to do |format|
        format.html { redirect_to new_user_url(:notice => "Usuario ya existe ó limite de usuarios excedido")}
        
      end
    end
  end

end
