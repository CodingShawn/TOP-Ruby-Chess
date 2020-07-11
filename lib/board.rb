require_relative 'rook'
require 'pry'

class Board
  attr_accessor :squares, :turn
  attr_reader :occupied_squares
  FILE = "abcdefgh"
  ROW_BORDERS = "   --- --- --- --- --- --- --- --- "
  
  def initialize
    @turn = "white"
    @squares = []
    8.times do
      row_array = []
      8.times {row_array.append(Piece.new)}
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

  def set_piece(location, type, colour)
    file = location[0]
    row = location[1]
    if type == "rook"
      @squares[file][row] = Rook.new(location, colour)
    end
  end

  def which_square_occupied
    occupied_squares = []
    for rows in @squares
      occupied_row_positions = rows.filter do |square|
        if square.type.nil?
          false
        else
          true
        end
      end
      for present_pieces_in_row in occupied_row_positions
        occupied_squares.append(present_pieces_in_row.location)
      end
    end 
    @occupied_squares = occupied_squares
  end                
end

x = Board.new
x.set_piece([0,0], "rook", "black")
x.set_piece([0,5], "rook", "white")
x.which_square_occupied
p x.squares[0][0].possible_moves(x.occupied_squares)