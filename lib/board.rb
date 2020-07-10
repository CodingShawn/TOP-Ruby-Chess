require_relative 'square'
require_relative 'rook'
require 'pry'

class Board
  attr_accessor :squares, :turn
  FILE = "abcdefgh"
  ROW_BORDERS = "   --- --- --- --- --- --- --- --- "
  
  def initialize
    @turn = "white"
    @squares = []
    8.times do
      row_array = []
      8.times {row_array.append(Square.new)}
      @squares.append(row_array)
    end
  end

  def draw_board
    puts ROW_BORDERS
    8.times do |row|
      row_image = "#{row} "
      8.times do |file|
        row_image += "| #{@squares[row][file].to_s} "
      end
      row_image += "|"
      puts row_image
      puts ROW_BORDERS
    end
    puts "    a   b   c   d   e   f   g   h"
  end

  def move_piece(start_location, end_location)
    check_if_player_piece(start_location)
  end

  def check_if_player_piece(start_location)
    square = @squares[start_location[0]][start_location[1]]
    square.colour == @turn ? true : false
  end
end

x = Board.new
x.squares[0][0].colour = "black"
x.squares[0][0].piece = "rook"
p x.check_if_player_piece([0,0])