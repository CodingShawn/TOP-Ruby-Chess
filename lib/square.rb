class Square
  attr_accessor :piece

  def initialize
    @piece = nil
  end

  def to_s
    if piece.nil?
      return " "
    else
    unicode = " "
      if @piece[0] == "white"
        if @piece[1] == "king"
          unicode = "\u2654"
        elsif @piece[1] == "queen"
          unicode = "\u2655"
        elsif @piece[1] == "rook"
          unicode = "\u2656"
        elsif @piece[1] == "bishop"
          unicode = "\u2657"
        elsif @piece[1] == "knight"
          unicode = "u2658"
        elsif @piece[1] == "pawn"
          unicode = "\u2659"
        end
      else
        if @piece[1] == "king"
          unicode = "\u265A"
        elsif @piece[1] == "queen"
          unicode = "\u265B"
        elsif @piece[1] == "rook"
          unicode = "\u265C"
        elsif @piece[1] == "bishop"
          unicode = "\u265D"
        elsif @piece[1] == "knight"
          unicode = "u265E"
        elsif @piece[1] == "pawn"
          unicode = "\u265F"
        end
      end
    end
    unicode.encode('utf-8')
  end
end