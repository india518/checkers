class Piece

  attr_reader :color, :display
  attr_accessor :position, :king
  
  def initialize(color, position)
    @color = color
    @position = position
    @king = false
    @display = get_display
  end
  
  def get_display
    case [@color, @king]
    when [:red, false]
      @display = :r
    when [:red, true]
      @display = :R
    when [:black, false]
      @display = :b
    when [:black, true]
      @display = :B
    end
  end

end