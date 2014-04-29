class Computer
  attr_accessor :board, :ships

  def initialize
    @ships = [Ship.new(5), Ship.new(3), Ship.new(4)]
    @board = Board.new
  end

  def get_coor(ship)
    ship.row = ('a'..'j').to_a.sample
    ship.col = (1..10).to_a.sample
    ship.direction = ['h', 'v'].sample
  end
end
