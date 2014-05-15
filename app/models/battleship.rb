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

  def get_choice
    c = (1..100).to_a
    a = (1..10).to_a
    b = %w(A B C D E F G H I J)
    choices = []
    b.each do |letter|
      a.each do |num|
        choices << letter + num.to_s
      end
    end
    Hash[c.zip(choices)]
  end

  def computer_attack(board, choices)
    # c = board.choices.shuffle.pop

    choice_hash =  get_choice
    # choice = choices.shuffle.pop
    c = choice_hash[choices]
    puts"++++++++++++"
    p c
    # p board.choices.length
    puts"++++++++++++"
    row = board.row_decoder[c[0]]
    col = c.length == 3 ? 10 : c[1].to_i
    if board.board[row][col] == "*"
      board.board[row][col] = 'X'
      # view.print_board(player.board)
      check = winner?(player.board)
      return ["HIT",row,col, check]
    else
      board.board[row][col] = '/'
      check = winner?(player.board)
      return ["MISS",row, col, check]
    end
  end

  def attack(coord, board)
    # check = false
    # until check
      # view.prompt_attack
      # attack = gets.chomp
      return["Invalid Coordinates"] if coord[1].to_i == 0
      row = board.row_decoder[coord[0].upcase]
      col = coord.length == 3 ? 10 : coord[1].to_i
      if board.board[row][col] == "*"
        board.board[row][col] = "X"
        check = winner?(computer.board)
        # computer_attack
        return ["HIT", row, col, check]
      elsif board.board[row][col] == "X" || board.board[row][col] == "/"
          return ["You already entered those coordinates"]
      else
        board.board[row][col] = "/"
        check = winner?(computer.board)
        # computer_attack
        return ["MISS", row, col, check]
      end
    # end
    # puts 'You Win!'
  end

  def winner?(board)
    !board.board.flatten.include?("*")
  end

  def place_ships(ship,player_type, board, shipInd)
    if player_type == "human"
      row = board.row_decoder[ship.row.upcase]
      return "Enter Number for Column" if ship.col.to_i == 0
      col = ship.col.to_i
    else
      ship.row = %w(A B C D E F G H I J).sample
      ship.col = (1..10).to_a.sample
      row = board.row_decoder[ship.row.upcase]
      col = ship.col.to_i
      ship.direction = ["hor", "vert"].sample
    end
    return "Can't place ship here" if row == nil || col == nil
    if ship.direction[0] == "h"
    puts ")))))))))))))))"
p row
p col
    p board.board[row][col...col+ship.length]
    puts ")))))))))))))))"
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
