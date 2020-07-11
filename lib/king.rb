require_relative 'piece'

class King < Piece
  def initialize(location, colour)
    super(location, colour)
    @type = "king"
  end

  def possible_moves(occupied_squares)
    result = [[@column - 1, @row], [@column - 1, @row + 1], [@column, @row + 1],
              [@column + 1, @row + 1], [@column + 1, @row], [@column + 1, @row - 1],
              [@column, @row - 1], [@column - 1, @row - 1]]
    #binding.pry
    prevent_off_board_moves(result)
  end
