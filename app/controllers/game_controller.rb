class GameController < ApplicationController

  def index
    @game = Battleship.new(Player.new, Computer.new)
    session[:game] = @game
    $redis.flushall
    test = []
    a = %w(A B C D E F G H I J)
    b = (1..10).to_a
    test = []
    a.each do |x|
      b.each do |y|
         test << x + y.to_s
      end
    end
    $redis.rpush('choices', test.shuffle )
  end

  def placeships
    game = session[:game]
    game.enter_coordinates(game.player.ships[params[:ship].to_i], params[:coord], params[:direction])
    b = game.place_ships(game.player.ships[params[:ship].to_i],'human', game.player.board, params[:ship].to_i)
    render json: b.to_json
  end

  def placecomp
    game = session[:game]
    check = true
    x = 0
    while check
      b = game.place_ships(game.computer.ships[x],'comp', game.computer.board, x)
      x += 1 if b.class != String
      x == 5 ? check = false : check = true
    end
    render :partial => 'attack'

  end

  def attack
    game = session[:game]
    response = game.attack(params[:coord], game.computer.board)
    $redis.rpush('taken choices', params[:coord] )
    render json: response.to_json
  end

 def compattack
    game = session[:game]
    choices = $redis.rpop('choices')
    response = game.computer_attack(game.player.board, choices)
    render json: response
 end

end