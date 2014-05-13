class Choices

  attr_accessor :choices
  def initialize
    a = (1..10).to_a
    b = %w(A B C D E F G H I J)
    @choices = []
    @row_decoder =  Hash[b.zip(a)]
    b.each do |letter|
      a.each do |num|
        @choices << letter + num.to_s
      end
    end
  end
end