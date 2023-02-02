class ResultsPagesController < ApplicationController
    before_action :logged_in?, only:[:show]
    def show
        @game=Game.find(params[:id])
        @winners=@game.winners
        if @game
            session[:game_id]=nil
            session[:player_id]=nil
        end
    end
end
