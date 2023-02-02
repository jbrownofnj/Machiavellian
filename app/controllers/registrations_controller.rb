class RegistrationsController < ApplicationController
  def new
    @user=User.new
  end
  def create
    @user=User.new(registrations_params)
    @user.update(user_email:@user.user_email.downcase)
    if @user.save
      @user.make_example_game()
      flash[:notice]= "succeeded in making account"
      redirect_to root_path
    else

      render :new
    end
  end
  def registrations_params
    params.require(:user).permit(:user_email,:password,:password_confirmation)
  end
end