class LoginController < ApplicationController
  def new
    @user=User.new
  end

  def create
    @user=User.find_by(user_email: params[:user][:user_email].downcase)

    if @user&.authenticate(params[:user][:password])
      session[:user_id]=@user.id
      session[:game_id]=nil
      session[:player_id]=nil
      flash[:notice]="You have successfully logged in."
      redirect_to game_pages_path
    else
      flash[:notice]="Bad username or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id]= nil
    session[:game_id]=nil
    session[:player_id]=nil
    redirect_to root_path
  end
end
