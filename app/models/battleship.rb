class Battleship

  attr_accessor :player, :computer

  def initialize(player,computer)
    @player = player
    @computer = computer
  end

  def run
    # view.print_board(player.board)
    # place_ships(player.ships, 'human', player.board)
    # place_ships(computer.ships, 'comp', computer.board)
    # view.print_board(computer.board)
    # attack
  end

  def enter_coordinates(ship, coordinates, direction)
    square = coordinates
    ship.direction = direction
    ship.row = square[0]
    ship.col = square.length == 3 ? 10 : square[1]
  end

  def computer_attack
    row = computer.board.row_decoder[('a'..'j').to_a.sample.upcase]
    col = (1..10).to_a.sample
    if player.board.board[row][col] == "*" || player.board.board[row][col] == "X"
      puts "Computer hits your ship"
      player.board.board[row][col] = 'X'
      view.print_board(player.board)
      check = check_board(player.board)
      return "You Lose" if check == true
    else
      puts "Computer misses your ship"
      player.board.board[row][col] = '/'
      view.print_board(player.board)
      check = check_board(player.board)
      return "You Lose" if check == true
    end


  end

  def attack
    check = false
    until check
      view.prompt_attack
      attack = gets.chomp
      row = computer.board.row_decoder[attack[0].upcase]
      col = attack.length == 3 ? 10 : attack[1].to_i
      if computer.board.board[row][col] == "*" || computer.board.board[row][col] == "X"
        puts "hit"
        computer.board.board[row][col] = "X"
        check = check_board(computer.board)
        view.print_board(computer.board)
        computer_attack
      else
        puts "miss"
        computer.board.board[row][col] = "/"
        check = check_board(computer.board)
        view.print_board(computer.board)
        computer_attack
      end
    end
    puts 'You Win!'
  end

  def check_board(board)
    !board.board.flatten.include?("*")
  end

  def place_ships(ship,player_type, board, shipInd)
    if player_type == "human"
      row = board.row_decoder[ship.row.upcase]
      col = ship.col.to_i
    else
      row = (1..10).to_a.sample
      col = (1..10).to_a.sample
    end
    return "Can't place ship here" if row == nil || col == nil
    if ship.direction[0] == "h"
      if board.board[row][col..col+ship.length].include?("*") || col+ship.length > 11
        return "Can't place ship here"
      else
        board.place_ship(ship)
        return [row,col,ship.length,ship.direction, shipInd]
      end
    else
      vert = []
      if row + ship.length > 11
        vert << "*"
      else
        ship.length.times do
          vert << board.board[row][col]
          row +=1
        end
      end
      if vert.include?("*") || ship.direction == ""
        return "Can't place ship here"
      else
        board.place_ship(ship)
        return [row-ship.length,col,ship.length,ship.direction, shipInd]
      end
    end
  end

end
