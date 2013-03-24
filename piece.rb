class Piece

  attr_reader :color, :display
  attr_accessor :king
  
  def initialize(color)
    @color = color
    @king = false
    @display = get_display
  end
  
  def get_display
    case [@color, @king]
    when [:red, false]
      @display = :r.to_s.colorize(:red)
    when [:red, true]
      @display = :R.to_s.colorize(:red)
    when [:black, false]
      @display = :b.to_s.colorize(:black)
    when [:black, true]
      @display = :B.to_s.colorize(:black)
    end
  end
  
  def vectors
    case @display
    when :r
      [[1,-1],[1,1]]
    when :b
      [[-1,-1],[-1,1]]
    else #kings move both ways
      [[1,-1],[1,1],[-1,-1],[-1,1]]
    end
  end

end









