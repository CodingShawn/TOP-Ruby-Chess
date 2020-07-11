require_relative 'board'

class Game
  attr_reader :turn
  def initialize
    @board = Board.new
    @turn = "white"
  end

  def change_turn
    if @turn.eql? "white"
      @turn = "black"
    else
      @turn = "white"
    end
  end
end