class Ship

  attr_accessor :length, :row, :col, :direction

  def initialize(length, row=nil, col=nil, direction=nil)
    @length = length
    @row = row
    @col = col
    @direction = direction
  end

end
