class RegistrationsController < ApplicationController

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_email:registrations_params[:user_email].downcase,password:registrations_params[:password])
    #Checks that password and confirmation are equal
    if params[:user][:password]==params[:user][:password_confirmation]
      if @user.save
        @user.make_example_game()
        flash[:notice]= "You have successfully made your account."
        session[:user_id]=@user.id
        redirect_to root_path
      else
        if @user.errors
          #Groups errors into one string.
          @error_response=""
          @user.errors.each do |error|
            @user.errors.each do |error|
              if error.attribute==:user_email
                @error_response="That email is invalid."
              end
            end
            if error.attribute==:password
              @error_response+=error.type+", "
            end
          end
        end
        flash[:notice]=@error_response
        @user=User.new(user_email:registrations_params[:user_email])
        render :new, status: :unprocessable_entity
      end
    else
      flash[:notice]="Password and Password Confirmation do not match"
      @user=User.new(user_email:registrations_params[:user_email])
      render :new, status: :unprocessable_entity
    end
  end
  def registrations_params
    params.require(:user).permit(:user_email,:password,:password_confirmation)
  end
end