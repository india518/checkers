require 'colorize'
load 'board.rb'
load 'player.rb'
load 'piece.rb'

class Checkers
  attr_accessor :board
  attr_reader :current_player
  
  def initialize
    @board = Board.new
    @red = HumanPlayer.new(:red)
    @black = HumanPlayer.new(:black)
    @current_player = @red
  end

  def play
    game_over = false
    
    until game_over
      board.display
      move = current_player.get_move
      
      until valid_move?(move)
        move = current_player.get_move
      end
      board.do_move(move)
      board.make_kings
      #TODO: Implement continuing turn for current_player
      # is there another move for the player to make?
      # i.e. another jump, or a choice between two possible jumps.
      # Do we automatically make another jump, or do we make the user
      # give us the turn?
      game_over = win?
      switch_player unless game_over
    end
    
    puts "Yay, you win, #{current_player.color}!"
  end
  
  def valid_move?(move)
    begin
      board.validate_move(move, current_player.color)
    rescue RuntimeError => e
      current_player.inform_invalid_move(e.message)
    end
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
game.play