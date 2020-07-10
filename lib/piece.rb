class Piece
  attr_accessor :type
  attr_reader :possible_moves
  def initialize(location, colour)
    @type = nil
    @location = location
    @column = @location[0]
    @row = @location[1]
    @colour = colour
    @possible_moves = possible_moves
  end

  def move(end_location)
    is_move_legal ? end_location : @location
  end

  def is_move_legal
  end

  def possible_moves
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
end 