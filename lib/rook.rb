require_relative 'piece'

class Rook < Piece
  def initialize(location, colour)
    super(location, colour)
    @type = "rook"
  end

  def is_move_illegal
  end

  def possible_moves
    result = []
    for i in 1..8
      result.append([(@column + i), @row])
      result.append([(@column - i), @row])
      result.append([@column, (@row + i)])
      result.append([@column, (@row - i)])
    end
    prevent_off_board_moves(result)
  end

  def to_s
    unicode = ""
    if @colour == "white"
      unicode = "\u2656"
    else
      unicode = "\u265C"
    end
    unicode.encode('utf-8')
  end
end

# x = Rook.new([5,5], "black")
# print x.possible_moves