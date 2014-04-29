class Player

  attr_accessor :board, :ships

  def initialize
    @ships = [Ship.new(5), Ship.new(3), Ship.new(4)]
    @board = Board.new
  end
end