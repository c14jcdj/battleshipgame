class Battleship

  attr_accessor :player, :computer

  def initialize(player,computer)
    @player = player
    @computer = computer
  end

  def enter_coordinates(ship, coordinates, direction)
    square = coordinates
    ship.direction = direction
    ship.row = square[0]
    if square.length == 3 && square[1..-1] == '10'
      ship.col = square[1..-1]
    elsif square.length == 2
      ship.col = square[1]
    else
      ship.col = 'a'
    end
  end

  def computer_attack(board, choices)
    c = choices
    row = board.row_decoder[c[0]]
    col = c.length == 3 ? 10 : c[1].to_i
    if board.board[row][col] == "*"
      board.board[row][col] = 'X'
      check = winner?(player.board)
      return ["HIT",row,col, check]
    else
      board.board[row][col] = '/'
      check = winner?(player.board)
      return ["MISS",row, col, check]
    end
  end

  def attack(coord, board)
      taken = $redis.lrange('taken choices', 0, -1)

      return["Invalid Coordinates"] if (coord[1].to_i == 0) || (coord.length > 3)
      return["Invalid Coordinates"] if coord.length == 3 && coord[1..-1] != '10'
      return ["You already entered those coordinates"] if taken.include?(coord)
      row = board.row_decoder[coord[0].upcase]
      col = coord.length == 3 ? 10 : coord[1].to_i
      if board.board[row][col] == "*"
        board.board[row][col] = "X"
        check = winner?(computer.board)
        return ["HIT", row, col, check]
      else
        board.board[row][col] = "/"
        check = winner?(computer.board)
        return ["MISS", row, col, check]
      end
  end

  def winner?(board)
    !board.board.flatten.include?("*")
  end

  def place_ships(ship,player_type, board, shipInd)
    if player_type == "human"
      row = board.row_decoder[ship.row.upcase]
      return "Invalid Coordinates" if ship.col.to_i == 0
      return "Must Enter A Direction" if ship.direction == nil
      col = ship.col.to_i
    else
      ship.row = %w(A B C D E F G H I J).sample
      ship.col = (1..10).to_a.sample
      row = board.row_decoder[ship.row.upcase]
      col = ship.col.to_i
      ship.direction = ["hor", "vert"].sample
    end
    return "Invalid Coordinates" if row == nil || col == nil
    if ship.direction[0] == "h"
      if board.board[row][col...col+ship.length].include?("*") || col+ship.length > 11
        return "Can't place ship here"
      else
        board.place_ship(ship, board)
        return [row,ship, shipInd]
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
        board.place_ship(ship, board)
        return [row-ship.length, ship, shipInd]
      end
    end
  end

end
