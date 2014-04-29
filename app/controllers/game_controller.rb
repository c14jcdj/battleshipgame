class GameController < ApplicationController

  def index
    @game = Battleship.new(Player.new, Computer.new)
    session[:game] = @game
  end

  def placeships
    @game = session[:game]
    @game.enter_coordinates(@game.player.ships[params[:ship].to_i], params[:coord], params[:direction])
    b = @game.place_ships(@game.player.ships[params[:ship].to_i],'human', @game.player.board)
    render json: b.to_json
  end

end