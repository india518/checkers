class Board
  
  attr_accessor :grid
  
  def initialize
    self.grid = Array.new(8) { Array.new(8) }
    place_red_pieces
    place_black_pieces
  end
  
  def place_red_pieces
    [0,2,4,6].each do |y|
      self.grid[0][1+y] = Piece.new(:red, [0, 1+y])
      self.grid[1][0+y] = Piece.new(:red, [1, 0+y])
      self.grid[2][1+y] = Piece.new(:red, [2, 1+y])
    end
  end
  
  def place_black_pieces
    [0,2,4,6].each do |y|
      self.grid[5][0+y] = Piece.new(:black, [5, 0+y])
      self.grid[6][1+y] = Piece.new(:black, [6, 1+y])
      self.grid[7][0+y] = Piece.new(:black, [7, 0+y])
    end
  end
  
  def display
    print "    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n"
    8.times do |x|
      print "#{x} : "
      8.times do |y|
        if self.grid[x][y].nil?
          print "|   " 
        else
          print "| #{self.grid[x][y].display} "
        end
      end
      print "|\n"
    end
  end
  
  
  def validate_move(move_path)
    #move path can be any length, because there can be more than one move!
    unchecked_move_path = move_path.dup
    
    start_point = mo
	  number_of_moves = move_path.length
    
    #move_path.each do |location|
	
  end

  def valid_square?(location)
    # locaton is an array: [x,y]
    unless (0..7).include?(location[0]) && (0..7).include?(location[1])
      puts "#{location[0]},#{location[1]} is not even on the board!"
      return false
    end
    
    if location[0].even? && location[1].even?
      puts "#{location[0]},#{location[1]} is not a valid square."
      return false
    elsif location[0].odd? && location[1].odd?
      puts "#{location[0]},#{location[1]} is not a valid square."
      return false
    end
    
    true
  end
  
  def do_move
    
  end
  
end