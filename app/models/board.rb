class Board

  attr_reader :row_decoder
  attr_accessor :board

def initialize
    @board =[[nil,  "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" ],
             [  "A",  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
             [  "B",  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
             [  "C",  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
             [  "D",  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
             [  "E",  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
             [  "F",  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
             [  "G",  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
             [  "H",  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
             [  "I",  nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
             [  "J", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ] ]
    a = (1..10).to_a
    b = %w(A B C D E F G H I J)
    @row_decoder =  Hash[b.zip(a)]
  end

  def place_ship(ship, board)
    row = row_decoder[ship.row.upcase]
    col = ship.col.to_i
    if ship.direction[0].downcase == "h"
      ship.length.times do
        board.board[row][col] = '*'
        col += 1
      end
    else
      ship.length.times do
        board.board[row][col] = '*'
        row +=1
      end
    end
  end

end