class Square
  attr_accessor :piece

  def initialize
    @piece = nil
  end

  def to_s
    @piece.nil?
    return " "
  end
end