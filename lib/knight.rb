class Knight < Pawn
  def initialize(location, colour)
    super(location, colour)
    @type = "knight"
  end

  def possible_moves(occupied_squares)
    #occupied_squares redundant as knight does not get blocked
    result = [
      [@column + 2, @row + 1], [@column + 2, @row - 1], 
      [@column - 2, @row + 1], [@column - 2, @row - 1],
      [@column + 1, @row + 2], [@column - 1, @row + 2],
      [@column + 1, @row - 2], [@column - 1, @row - 2]]
    prevent_off_board_moves(result)
  end

  def to_s
    if @colour == "black"
      unicode = "\u2658"
    else
      unicode = "\u265E"
    end
    unicode.encode('utf-8')
  end
end