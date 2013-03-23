class Player
  
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
  
  def get_move
    
  end

  def inform_invalid_move
    puts "Bad move, try again"
    # Use Exceptions to let the user know WHY the move is bad!
  end
  
end

class HumanPlayer < Player
  
end