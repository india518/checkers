require 'debugger'

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
    print "  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n"
    8.times do |row|
      print "#{row} "
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
    return false unless valid_square?(start_point)
    return false unless valid_square?(end_point)   
    return false unless valid_piece?(start_point, color)
    return false unless square_empty?(end_point)
    return true if slide_one_good?(start_point, end_point)
    #is the end point one jump (two squares) away in the right direction?
    return true if valid_jump?(start_point, end_point)
    false #we aren't sliding up and we aren't making a jump:
  end
  
  def valid_square?(location)
    # locaton is an array: [x,y]
    # TODO: take out the puts and raise exceptions instead
    unless (0..7).include?(location[0]) && (0..7).include?(location[1])
      raise RuntimeError.new "#{location[0]},#{location[1]} is not even on the board!"
    end
    if location[0].even? && location[1].even?
      raise RuntimeError.new "#{location[0]},#{location[1]} is not a valid square."
    elsif location[0].odd? && location[1].odd?
      raise RuntimeError.new "#{location[0]},#{location[1]} is not a valid square."
    end
    true
  end
  
  def valid_piece?(location, color)
    if grid[location[0]][location[1]].nil?
      raise RuntimeError.new "There is no piece to move on #{location[0]},#{location[1]}"
    elsif color != grid[location[0]][location[1]].color
      raise RuntimeError.new "This piece does not belong to you!"
    end
    true
  end
  
  def square_empty?(location)
    unless grid[location[0]][location[1]].nil?
      raise RuntimeError.new "Can't move to an occupied square."
    end
    grid[location[0]][location[1]].nil?
  end

  def slide_one_good?(start_point, end_point)
    vectors = grid[start_point[0]][start_point[1]].vectors
    vectors.each do |vector| #TODO: can this be a helper function?
      possible_location = [start_point[0]+vector[0], start_point[1]+vector[1]]
      return true if possible_location == end_point #we got a good move!
    end
    raise RuntimeError.new "You can't move that piece in that direction."
  end

  def valid_jump?(start_point, end_point)
    possible_locations = []
    piece = grid[start_point[0]][start_point[1]]
    vectors = piece.vectors
    
    # jump means we have a multiplier of 2. TODO: Again, can this be a helper?
    vectors.each do |vector|
      middle_spot = [start_point[0]+vector[0], start_point[1]+vector[1]]
      possible_location = [start_point[0]+(vector[0]*2), start_point[1]+(vector[1]*2)]
      
      if possible_location == end_point
        #is there an enemy in between?
        if grid[middle_spot[0]][middle_spot[1]].nil?
          raise RuntimeError.new "You can't jump an empty spot."
        elsif grid[middle_spot[0]][middle_spot[1]].color == piece.color
          raise RuntimeError.new "You can't jump your own piece."
        elsif grid[middle_spot[0]][middle_spot[1]].color != piece.color
          return true #yay, found it!
        end
      end
    end
    raise RuntimeError.new "You can't move that piece in that direction."
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
      #ok because end_spot != end_point if we're only jumping one space!
      end_spot = [start_point[0]+(vector[0]*2), start_point[1]+(vector[1]*2)]
      return middle_spot if end_spot == end_point
    end
    nil
  end

  def make_kings
    black_king_row = self.grid[0]
    red_king_row = self.grid[7]
    black_king_row.each do |square| 
      if square && square.color == :black
        square.king = true
        square.get_display
      end
    end
    red_king_row.each do |square| 
      if square && square.color == :red
        square.king = true
        square.get_display
      end
    end
  end
  
end