class GamePageController < ApplicationController
  before_action :set_user ,only: [:index,:status,:show]
  before_action :logged_in?, only:[:index,:show,:new,:leave_game_page]
  def index
    @players=@user.players
      if session[:game_id]
        @player=Player.find(session[:player_id])
        @game=Game.find(session[:game_id])
        @round=@game.current_round
        if @game.is_over
          session[:game_id]=nil
          session[:player_id]=nil
          redirect_to results_page_url(@game)
        end
      else
        @game=Game.new
        @game.players.build
        @game.players.first.user=@user
      end
    
  end

  def new
    @user=User.find(session[:user_id])
    if @user.valid?
      
    else 
      redirect_to root_path
    end
  end

  def show
    if params[:game]
      @game=Game.find_by(id:params[:game])
    else
      @game=Game.find_by(id:session[:game_id])
    end
    if @game&.is_over
      session[:game_id]=nil
      session[:player_id]=nil
      redirect_to results_page_url(@game) and return
    elsif @game
      @first_time_seeing_new_round=false
      if session[:last_round_seen] != @game.current_round.id
        @first_time_seeing_new_round=true
        session[:last_round_seen]=@game.current_round.id
      end
      if @game.players.exists?(user:session[:user_id])
        session[:game_id]=@game.id
        session[:player_id]=@game.players.find_by(user:session[:user_id]).id
        @player=Player.find(session[:player_id])
        @round=@game.current_round
        if @game.is_over
          session[:game_id]=nil
          session[:player_id]=nil
          redirect_to results_page_url(@game) and return
        end
        render :show, status:422
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
   
  end
  def leave_game_page
    session[:player_id]=nil
    session[:game_id]=nil
    redirect_to game_pages_path
  end

end
