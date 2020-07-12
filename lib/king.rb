require_relative 'piece'
require 'pry'

class King < Piece
  def initialize(location, colour)
    super(location, colour)
    @type = "king"
  end

  def possible_moves(occupied_squares, opponent_zone_of_control)
    result = [[@column - 1, @row], [@column - 1, @row + 1], [@column, @row + 1],
              [@column + 1, @row + 1], [@column + 1, @row], [@column + 1, @row - 1],
              [@column, @row - 1], [@column - 1, @row - 1]]
    result -= opponent_zone_of_control
    #prevent king from moving in to square where it will get checked
    prevent_off_board_moves(result)
  end

  def to_s
    unicode = ""
    if @colour == "white"
      unicode = "\u2654"
    else
      unicode = "\u265A"
    end
    unicode.encode('utf-8')
  end
end
