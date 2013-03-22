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
  
  
  def validate_move
    
  end
  
  def do_move
    
  end
  
end