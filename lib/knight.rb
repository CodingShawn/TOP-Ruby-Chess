class Knight < Pawn
  def initialize(location, colour)
    super(location, colour)
    @type = "knight"
  end

  def possible_moves(occupied_squares)
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