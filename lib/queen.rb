class Queen < Pawn
  def initialize(location, colour)
    super(location, colour)
    @type = "queen"
  end

  def possible_moves(occupied_squares)
    route1 = []
    route2 = []
    route3 = []
    route4 = []
    route5 = []
    route6 = []
    route7 = []
    route8 = []
    for i in 1..7
      route1.append([(@column + i), @row])
      route2.append([(@column - i), @row])
      route3.append([@column, (@row + i)])
      route4.append([@column, (@row - i)])
      route5.append([@column + i, @row + i])
      route6.append([@column - i, @row + i])
      route7.append([@column + i, @row - i])
      route8.append([@column - i, @row - i])
    end
    result = []
    result.concat(remove_blocked_path(route1, occupied_squares))
    result.concat(remove_blocked_path(route2, occupied_squares))
    result.concat(remove_blocked_path(route3, occupied_squares))
    result.concat(remove_blocked_path(route4, occupied_squares))
    result.concat(remove_blocked_path(route5, occupied_squares))
    result.concat(remove_blocked_path(route6, occupied_squares))
    result.concat(remove_blocked_path(route7, occupied_squares))
    result.concat(remove_blocked_path(route8, occupied_squares))
    prevent_off_board_moves(result)
  end

  def to_s
    unicode = ""
    if @colour == "black"
      unicode = "\u2655"
    else
      unicode = "\u265B"
    end
    unicode.encode('utf-8')
  end
end