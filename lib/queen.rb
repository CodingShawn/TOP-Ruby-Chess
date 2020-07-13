class Queen < Pawn
  def initialize(location, colour)
    super(location, colour)
    @type = "queen"
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