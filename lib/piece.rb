class Piece
  attr_accessor :type
  def initialize(location)
    @type = nil
    @location = location
  end

  def move(end_location)
    is_move_legal ? end_location : @location
  end

  def is_move_legal
  end
end 