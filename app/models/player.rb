class Player

  attr_accessor :board, :ships

  def initialize
    @ships = [Ship.new(5, "ac"), Ship.new(4,"battleship"),Ship.new(3,'sub'),Ship.new(3, 'cruiser'),Ship.new(2,'destroyer')]
    @board = Board.new
  end
end