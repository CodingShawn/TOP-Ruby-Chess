require_relative 'piece'

class Rook < Piece
  def initialize(location, colour)
    super(location, colour)
    @type = "rook"
  end

  def possible_moves(occupied_squares)
    route1 = []
    route2 = []
    route3 = []
    route4 = []
    for i in 1..8
      route1.append([(@column + i), @row])
      route2.append([(@column - i), @row])
      route3.append([@column, (@row + i)])
      route4.append([@column, (@row - i)])
    end
    result = []
    result.concat(remove_blocked_path(route1, occupied_squares))
    result.concat(remove_blocked_path(route2, occupied_squares))
    result.concat(remove_blocked_path(route3, occupied_squares))
    result.concat(remove_blocked_path(route4, occupied_squares))
    prevent_off_board_moves(result)
  end

  def to_s
    if @colour == "black"
      unicode = "\u2656"
    else
      unicode = "\u265C"
    end
    unicode.encode('utf-8')
  end
end