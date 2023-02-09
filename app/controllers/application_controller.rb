class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_alert
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    
    def set_user
        @user ||= session[:user_id] && User.find(session[:user_id])
    end

    def logged_in?
        redirect_to root_path, status: :unauthorized unless set_user
    end

    def set_player
        @player=Player.find(session[:player_id])
    end

    def set_game 
        @game=Game.find(session[:game_id])
    end

    def is_admin?
        @admin_user=User.find(session[:user_id])
        flash[:notice]="Admin only process."
        redirect_to root_path, status: :unauthorized unless @admin_user.is_admin
    end
   

    private
    def invalid_record_alert(invalid)
        flash[:alert]= "Invalid record attempt maid"
        redirect_to game_page_show_path
    end
    
    def record_not_found(missing)
        flash[:alert]= "Record Missing"
        redirect_to game_page_show_path
    end

end
