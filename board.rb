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
    #move path has two arrays: i.e. [[2,1],[3,2]]
    start_point = move_path[0]
    end_point = move_path[1]
    
    #are both points valid?
    return false unless valid_square?(start_point)
    return false unless valid_square?(end_point)
    
    #is end point one square away in the right direction?
    return true if end_point.slide_one_good?(end_point)
    
    #is the end point one jump (two squares) away in the right direction?
    return true if end_point.jump?(end_point)	
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
  
  def do_move(start_location,end_location)
    playing_piece = grid[start_location[0]][start_location[1]]
    # Update board
    grid[start_location[0]][start_location[1]] = nil
    grid[end_location[0]][end_location[1]] = playing_piece
    #Update piece's position
    playing_piece.position = [end_location[0]][end_location[1]]
    # TODO:
    # Remove a jumped piece from the board!
    #
  end
  
end