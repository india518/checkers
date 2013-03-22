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
  end
  
  #run the game


  
end