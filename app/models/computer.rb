class Computer
  attr_accessor :board, :ships

  def initialize
    @ships = [Ship.new(5, "ac"), Ship.new(4,"battleship"),Ship.new(3,'sub'),Ship.new(3, 'cruiser'),Ship.new(2,'destroyer')]
    @board = Board.new
  end

  def get_coor(ship)
    ship.row = ('a'..'j').to_a.sample
    ship.col = (1..10).to_a.sample
    ship.direction = ['h', 'v'].sample
  end
end
