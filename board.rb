require_relative 'square'

class Board
  attr_accessor :squares
  FILE = "abcdefgh"
  ROW_BORDERS = "   --- --- --- --- --- --- --- --- "
  
  def initialize
    @squares = []
    64.times {@squares.append(Square.new)}
  end

  def draw_board
    puts ROW_BORDERS
    (8).downto(1) do |row|
      row_image = "#{row} "
      (8).downto(1) do |file|
        square_no = row * file - 1
        row_image += "| #{@squares[square_no].to_s} "
      end
      row_image += "|"
      puts row_image
      puts ROW_BORDERS
    end
    puts "    a   b   c   d   e   f   g   h"
  end
end