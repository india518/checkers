class Player
  
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
  
  def make_move
    
  end

  def inform_invalid_move
    
  end
  
end

class HumanPlayer < Player
  
end