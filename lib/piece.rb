class Piece
  attr_accessor :type
  attr_reader :location
  def initialize(location = [99,99], colour = nil)
    @type = nil
    @location = location
    @column = @location[0]
    @row = @location[1]
    @colour = colour
  end

  def move(end_location)
    is_move_legal ? end_location : @location
  end

  def is_move_legal
  end

  def possible_moves(occupied_squares)
  end

  def prevent_off_board_moves(initial_possible_moves)
    on_board_moves = initial_possible_moves.filter do |location|
      if location[0] < 0 || location[0] > 7 || location[1] < 0 || location[1] > 7
        false
      else
        true
      end
    end
    on_board_moves
  end
  
  def check_if_route_blocked(route, occupied_squares)
    unless route.empty?
      index = route.index {|path| occupied_squares.include? path}
    else
      -1
    end
  end

  def remove_blocked_path(route, occupied_squares)
    index = check_if_route_blocked(route, occupied_squares)
    route = route[0..index]
  end
  
  def to_s
    " "
  end
end 