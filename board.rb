class Board
  
  attr_accessor :grid
  
  def initialize
    self.grid = Array.new(8) { Array.new(8) }
    place_red_pieces
    place_black_pieces
  end
  
  def place_red_pieces
    [0,2,4,6].each do |y|
      self.grid[0][1+y] = Piece.new(:red)
      self.grid[1][0+y] = Piece.new(:red)
      self.grid[2][1+y] = Piece.new(:red)
    end
  end
  
  def place_black_pieces
    [0,2,4,6].each do |y|
      self.grid[5][0+y] = Piece.new(:black)
      self.grid[6][1+y] = Piece.new(:black)
      self.grid[7][0+y] = Piece.new(:black)
    end
  end
  
  def display
    print "    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n"
    8.times do |row|
      print "#{row} : "
      8.times do |column|
        if self.grid[row][column].nil?
          print "|   " 
        else
          print "| #{self.grid[row][column].display} "
        end
      end
      print "|\n"
    end
  end
  
  def validate_move(move, color)
    #move has two arrays: i.e. [[2,1],[3,2]]. Let's break it into points!
    start_point = move[0]
    end_point = move[1]
    #are both points valid?
    return false unless valid_square?(start_point)
    return false unless valid_square?(end_point)
    return false unless valid_piece?(start_point, color)
    return true if slide_one_good?(start_point, end_point)
    #is the end point one jump (two squares) away in the right direction?
    return true if valid_jump?(start_point, end_point)
    #if we aren't sliding up and we aren't making a jump,
    false
  end
  
  def valid_square?(location)
    # locaton is an array: [x,y]
    # TODO: take out the puts and raise exceptions instead
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
  
  def valid_piece?(location, color)
    color == grid[location[0]][location[1]].color
  end

  def slide_one_good?(start_point, end_point)
    #get vectors for start_point
    vectors = grid[start_point[0]][start_point[1]].vectors
    #can this be a helper function?
    vectors.each do |vector|
      possible_location = [start_point[0]+vector[0], start_point[1]+vector[1]]
      return true if possible_location == end_point #we got a good move!
    end
    false
  end

  def valid_jump?(start_point, end_point)
    possible_locations = []
    #get vectors for start_point
    piece = grid[start_point[0]][start_point[1]]
    vectors = piece.vectors
    
    #this is a jump, so our multiplier is 2! (enemy multiplier is 1)
    # TODO: again, can this be a helper function?
    vectors.each do |vector|
      middle_spot = [start_point[0]+vector[0], start_point[1]+vector[1]]
      possible_location = [start_point[0]+(vector[0]*2), start_point[1]+(vector[1]*2)]
      
      if possible_location == end_point
        #is there an enemy in between?
        if grid[middle_spot[0]][middle_spot[1]].nil?
          puts "You can't jump an empty spot!" #raise an exception later!!
          return false
        elsif grid[middle_spot[0]][middle_spot[1]].color == piece.color
          puts "You can't jump your own piece!" #raise an exception later!!
          return false
        elsif grid[middle_spot[0]][middle_spot[1]].color != piece.color
          #puts "This move is OK!"
          return true #yay!
        end
      end
    end
    #endpoint not in acceptable path
    false
  end
  
  def do_move(move)
    #move has two arrays: i.e. [[2,1],[3,2]]. Let's break it into points!
    start_point, end_point = move[0], move[1]
    playing_piece = grid[start_point[0]][start_point[1]].dup
    middle_piece = get_victim(start_point,end_point)
    # Update board
    self.grid[start_point[0]][start_point[1]] = nil
    self.grid[middle_piece[0]][middle_piece[1]] = nil if middle_piece
    self.grid[end_point[0]][end_point[1]] = playing_piece
  end
  
  def get_victim(start_point, end_point)
    playing_piece = grid[start_point[0]][start_point[1]]
    vectors = playing_piece.vectors
    
    vectors.each do |vector|
      middle_spot = [start_point[0]+vector[0], start_point[1]+vector[1]]
      #we can do this because end_spot will not match end_point if we are
      # only jumping one space!
      end_spot = [start_point[0]+(vector[0]*2), start_point[1]+(vector[1]*2)]
      if end_spot == end_point
          return middle_spot
      end
    end
    nil
  end

end