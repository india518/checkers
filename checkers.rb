require 'colorize'
load 'board.rb'
load 'player.rb'
load 'piece.rb'

class Checkers
  attr_accessor :board
  
  def initialize
    @board = Board.new
    #initialize two players
    @red = HumanPlayer.new(:red)
    @black = HumanPlayer.new(:black)
    @current_player = @red
  end

  def play
    
    until game_over?
      board.display
      valid_move = false
    
      until valid_move
        #ask for player's turn
        move = current_player.get_move    
        #check player's turn
        valid_move = board.validate_move(move, current_player.color)
        #do we have to ask again?
        current_player.inform_invalid_move unless valid_move
      end
  
      board.do_move(move) #make player's turn
      #switch player
      switch_player
    end
    
  end

  def switch_player
    if current_player == @red
      @current_player = @black
    else current_player == @black
      @current_player = @red
    end
  end
  
  def enemy_player
    if current_player == @red
      @black
    else current_player == @black
      @red
    end
  end
  
  def game_over?
    # are all enemy_player's pieces removed from board?
    #return true/false
  end
  
end