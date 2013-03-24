class Player
  
  attr_reader :color
  
  def initialize(color)
    @color = color
  end

  def inform_invalid_move(string = "Bad move, try again")
    puts string
  end
  
end

class HumanPlayer < Player
  
  def get_move
    move = [[],[]]
    puts "It's your turn, #{@color}."
    puts "Where is the piece that you want to move? (i.e. 2,1) "
    start_move = gets.chomp.split(',')
    move[0][0] = start_move[0].to_i
    move[0][1] = start_move[1].to_i
    puts "Where would you like to move it to? (i.e. 3,0) "
    end_move = gets.chomp.split(',')
    move[1][0] = end_move[0].to_i
    move[1][1] = end_move[1].to_i
    move
  end
end

class ComputerPlayer < Player
  
end