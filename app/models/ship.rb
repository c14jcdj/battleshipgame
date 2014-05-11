class Ship

  attr_accessor :length, :row, :col, :direction, :name

  def initialize(length,name, row=nil, col=nil, direction=nil)
    @length = length
    @name = name
    @row = row
    @col = col
    @direction = direction
  end

end
