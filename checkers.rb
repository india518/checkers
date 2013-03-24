require 'colorize'
load 'board.rb'
load 'player.rb'
load 'piece.rb'

class Checkers
  attr_accessor :board
  attr_reader :current_player
  
  def initialize
    @board = Board.new
    #initialize two players
    @red = HumanPlayer.new(:red)
    @black = HumanPlayer.new(:black)
    @current_player = @red
  end

  def play
    game_over = false
    
    until game_over
      board.display
      valid_move = false
    
      until valid_move
        move = current_player.get_move
        begin
          valid_move = board.validate_move(move, current_player.color)
        rescue RuntimeError => e
          current_player.inform_invalid_move(e.message)
        end
        #can take this out?
        #current_player.inform_invalid_move unless valid_move
      end
  
      board.do_move(move)
      #TODO:
      # is there another move for the player to make
      # i.e. another jump, or a choice between two possible jumps
      # Do we automatically make another jump, or do we make the user
      # give us the turn?
      game_over = win?
      switch_player unless game_over
    end
    
    puts "Yay, #{current_player.color} wins!"
  end

  def switch_player
    if @current_player == @red
      @current_player = @black
    else @current_player == @black
      @current_player = @red
    end
  end
  
  def win?
    enemy_count = []
    @board.grid.each do |row|
      row.each do |square| 
        enemy_count << square unless square.nil? || square.color == @current_player.color
      end
    end
    return true if enemy_count.empty?
    false
  end
  
end

game = Checkers.new