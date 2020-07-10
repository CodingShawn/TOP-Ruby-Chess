class Square
  attr_accessor :piece, :colour

  def initialize
    @piece = nil
    @colour = nil
  end

  def to_s
    if piece.nil?
      return " "
    else
    unicode = " "
      if @colour == "white"
        if  @piece == "king"
          unicode = "\u2654"
        elsif @piece == "queen"
          unicode = "\u2655"
        elsif @piece == "rook"
          unicode = "\u2656"
        elsif @piece == "bishop"
          unicode = "\u2657"
        elsif @piece == "knight"
          unicode = "u2658"
        elsif @piece == "pawn"
          unicode = "\u2659"
        end
      else
        if @piece == "king"
          unicode = "\u265A"
        elsif @piece == "queen"
          unicode = "\u265B"
        elsif @piece == "rook"
          unicode = "\u265C"
        elsif @piece == "bishop"
          unicode = "\u265D"
        elsif @piece == "knight"
          unicode = "u265E"
        elsif @piece == "pawn"
          unicode = "\u265F"
        end
      end
    end
    unicode.encode('utf-8')
  end
end