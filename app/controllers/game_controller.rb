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
    puts "+++++++++++++"
    p $redis.lrange('choices', 0, -1)
    puts "+++++++++++++"
    # session[:choices] = (1..100).to_a
  end

  def placeships
    game = session[:game]
    puts "++++++++++++"
    p params
    puts "++++++++++++"
    game.enter_coordinates(game.player.ships[params[:ship].to_i], params[:coord], params[:direction])
    puts"++++++++++++++"
    p game.player.ships[params[:ship].to_i]
    puts"++++++++++++++"
    b = game.place_ships(game.player.ships[params[:ship].to_i],'human', game.player.board, params[:ship].to_i)
    game.player.board.board.each do |x|
      x.each do |y|
        print "#{y}\t"
      end
      puts
    end
    render json: b.to_json
  end

  def placecomp
    game = session[:game]
    check = true
    x = 0
    while check
      puts "+++++++++"
      p x
      puts "+++++++++"
      b = game.place_ships(game.computer.ships[x],'comp', game.computer.board, x)
      puts "--------------"
      p b
      puts "--------------"
      x += 1 if b.class != String
      x == 5 ? check = false : check = true
    end
    game.computer.board.board.each do |x|
      x.each do |y|
        print "#{y}\t"
      end
      puts
    end
    render :partial => 'attack'

  end

  def attack
    puts "--------------"
    p params
    puts "+++++++++++"
    game = session[:game]
    response = game.attack(params[:coord], game.computer.board)
    $redis.rpush('taken choices', params[:coord] )
    render json: response.to_json
  end

 def compattack
    game = session[:game]
    puts "[[[[[[[[[[[[[[["

    p $redis.llen('choices')
    p choices = $redis.rpop('choices')
    p $redis.llen('choices')
    puts "[[[[[[[[[[[[[[["
    # session[:choices].shuffle!
    # choices = session[:choices].pop
    response = game.computer_attack(game.player.board, choices)

    render json: response
 end

end