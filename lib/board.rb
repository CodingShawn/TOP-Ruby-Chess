require_relative 'rook'
require_relative 'king'
require 'pry'

class Board
  attr_accessor :squares, :turn
  attr_reader :occupied_squares
  FILE = "abcdefgh"
  ROW_BORDERS = "   --- --- --- --- --- --- --- --- "
  
  def initialize
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

  def move_piece(start_location, end_location, turn)
    which_square_occupied
    piece = @squares[start_location[0]][start_location[1]]
    if check_if_player_piece(piece, turn) && 
       check_move_possible(piece, end_location, turn)
      if @occupied_squares.include? end_location
        #see if the end location is occupied by other or own colour
        unless check_if_enemy_piece(piece, end_location)
          return false #inform Game class move is illegal
        end
      end
      move_to_end_location(piece, end_location, turn)
      clear_start_location(piece, start_location)
      return true #inform Game class move is legal
    end
    return false
  end

  def move_to_end_location(piece, end_location, turn)
    #create piece at end point
    set_piece(end_location, piece.type, turn)
  end

  def clear_start_location(piece, start_location)
    #remove piece at start point
    @squares[start_location[0]][start_location[1]] = Piece.new
  end

  def check_move_possible(piece, end_location, turn)
    if piece.type == 'king'
      #if king, have to check if move will cause the king piece to be checked
      piece.possible_moves(@occupied_squares, zone_of_control(turn)).include? end_location
    else
      piece.possible_moves(@occupied_squares).include? end_location
    end
  end

  def check_if_player_piece(piece, turn)
    piece.colour.eql? turn
  end

  def check_if_enemy_piece(piece, end_location)
    other_piece = @squares[end_location[0]][end_location[1]]
    return piece.colour != other_piece.colour
  end

  def set_piece(location, type, colour)
    file = location[0]
    row = location[1]
    case type
    when "rook"
      @squares[file][row] = Rook.new(location, colour)
    when "king"
      @squares[file][row] = King.new(location, colour)
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

  def check_pieces(turn)
    one_side_pieces = []
    #collate all pieces of other player into array
    for row in @squares
      one_side_row_pieces = row.filter do |square|
        if square.colour != turn && square.colour != nil
          true
        else
          false
        end
      end
      unless one_side_row_pieces.empty?
       one_side_pieces.concat(one_side_row_pieces)
      end
    end
    one_side_pieces
  end

  def zone_of_control(turn)
    opposing_pieces = check_pieces(turn)
    zone_of_control = []
    for piece in opposing_pieces
      zone_of_control.concat(piece.possible_moves(@occupied_squares))
    end
    zone_of_control
  end
end

x = Board.new
x.set_piece([6,0], "rook", "white")
x.set_piece([6,5], "rook", "black")
x.set_piece([5,6], "king", "black")
x.which_square_occupied
x.draw_board
x.move_piece([5,6], [4,5], "black")
x.draw_board
