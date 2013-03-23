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
    game_over = false
    
    until game_over
      board.display
      valid_move = false
    
      until valid_move
        move = current_player.get_move
        valid_move = board.validate_move(move, current_player.color)
        current_player.inform_invalid_move unless valid_move
      end
  
      board.do_move(move)
      switch_player unless game_over = win?
    end
    
    puts "Yay, #{current_player.color} wins!"
  end

  def switch_player
    if current_player == @red
      @current_player = @black
    else current_player == @black
      @current_player = @red
    end
  end
  
  def win?
    # are all enemy_player's pieces removed from board?
    # iterate over board for enemy color
    enemy_count = []
    
    #board.grid.length
    @board.grid.each do |row|
      row.each do |square| 
        enemy_count << square unless square.nil? || square.color == @current_player.color
      end
    end
    return true if enemy_count.empty?
    false
  end
  
end