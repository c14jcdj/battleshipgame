class GameController < ApplicationController

  def index
    @game = Battleship.new(Player.new, Computer.new)
    session[:game] = @game
  end

  def placeships
    game = session[:game]
    game.enter_coordinates(game.player.ships[params[:ship].to_i], params[:coord], params[:direction])
    b = game.place_ships(game.player.ships[params[:ship].to_i],'human', game.player.board, params[:ship].to_i)
    # game.player.board.board.each do |x|
    #   x.each do |y|
    #     print "#{y}\t"
    #   end
    #   puts
    # end
    render json: b.to_json
  end

  def placecomp
    game = session[:game]
    5.times do |x|
      puts "+++++++++"
      p x
      puts "+++++++++"
      game.place_ships(game.computer.ships[x],'comp', game.comp.board, x)
    end
    game.computer.board.board.each do |x|
      x.each do |y|
        print "#{y}\t"
      end
      puts
    end
    render json: true

  end

end