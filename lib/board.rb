require_relative 'rook'
require_relative 'king'
require_relative 'pawn'
require_relative 'knight'
require_relative 'queen'
require_relative 'bishop'
require 'pry'

class Board
  attr_accessor :squares, :turn
  attr_reader :occupied_squares
  FILE = "abcdefgh"
  ROW_BORDERS = "   --- --- --- --- --- --- --- --- "
  
  def initialize
    @squares = []
    8.times do
      column_array = []
      8.times {column_array.append(Piece.new)}
      @squares.append(column_array)
    end
    8.times do |i|
      set_piece([i, 1], "pawn", "black")
      set_piece([i, 6], "pawn", "white")
    end
    set_piece([0, 0], "rook", "black")
    set_piece([7, 0], "rook", "black")
    set_piece([0, 7], "rook", "white")
    set_piece([7, 7], "rook", "white")
    set_piece([1, 0], "knight", "black")
    set_piece([6, 0], "knight", "black")
    set_piece([1, 7], "knight", "white")
    set_piece([6, 7], "knight", "white")
    set_piece([2, 0], "bishop", "black")
    set_piece([5, 0], "bishop", "black")
    set_piece([2, 7], "bishop", "white")
    set_piece([5, 7], "bishop", "white")
    set_piece([3, 0], "queen", "black")
    set_piece([3, 7], "queen", "white")
    set_piece([4, 0], "king", "black")
    set_piece([4, 7], "king", "white")
  end

  def draw_board
    puts ROW_BORDERS
    8.times do |column|
      column_image = "#{column} "
      8.times do |row|
        column_image += "| #{@squares[row][column].to_s} "
      end
      column_image += "|"
      puts column_image
      puts ROW_BORDERS
    end
    puts "    a   b   c   d   e   f   g   h"
  end

  def move_piece(start_location, end_location, turn)
    state_before_move = @squares.clone.map(&:clone) #make a copy of original positions
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
      check_pawn_promotion(piece, end_location, turn)
      if check_if_move_results_in_check(turn)
        #rewind move if move results in ownself being checked
        @squares = state_before_move
        return false
      else
      return true #inform Game class move is legal
      end 
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
      possible_moves_helper(piece, turn).include? end_location
  end

  def possible_moves_helper(piece, turn)
    if piece.type == "pawn"
      check_pieces
      if turn == "black"
        opposing_pieces = @white_pieces
      else
        opposing_pieces = @black_pieces
      end
      piece.possible_moves(@occupied_squares, opposing_pieces)
    else
      piece.possible_moves(@occupied_squares)
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
    when "pawn"
      @squares[file][row] = Pawn.new(location, colour)
    when "knight"
      @squares[file][row] = Knight.new(location, colour)
    when "queen"
      @squares[file][row] = Queen.new(location, colour)
    when "bishop"
      @squares[file][row] = Bishop.new(location, colour)
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

  def check_pieces
    @black_pieces = check_pieces_helper("black")
    @white_pieces = check_pieces_helper("white")
    #collate each side pieces into array
  end

  def check_pieces_helper(colour)
    one_side_pieces = []
    for row in @squares
      one_side_row_pieces = row.filter do |square|
        if square.colour == colour
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

  def opposing_zone_of_control(turn)
    check_pieces
    which_square_occupied
    if turn == "black"
      opposing_pieces = @white_pieces
    else
      opposing_pieces = @black_pieces
    end
    zone_of_control = []
    for piece in opposing_pieces
      zone_of_control.concat(possible_moves_helper(piece, turn))
    end
    zone_of_control
  end

  def check_if_move_results_in_check(colour)
    #This method checks if player making the turn has been checked as a result of own move
    opposing_zone_of_control = opposing_zone_of_control(colour)
    if colour == "black"
      current_player_pieces = @black_pieces
    else
      current_player_pieces = @white_pieces
    end
    current_player_king = current_player_pieces.filter {|piece| piece.type == 'king'}
    current_player_king_location = current_player_king[0].location
    opposing_zone_of_control.include? current_player_king_location
  end

  def check_if_checkmake(turn)
    #The method checks if player making the turn has checked mate the opposing player
    current_state_of_board = @squares.clone.map(&:clone)
    check_pieces
    which_square_occupied
    moves_that_result_in_check = []
    if turn == "black"
      other_player = "white"
      other_player_pieces = @white_pieces
    else
      other_player = "black"
      other_player_pieces = @black_pieces
    end
    for piece in other_player_pieces
      for possible_move in possible_moves_helper(piece, turn)
        @squares = current_state_of_board.clone.map(&:clone)
        move_piece(piece.location, possible_move, other_player)
        moves_that_result_in_check.append(check_if_move_results_in_check(other_player))
        check_pieces
        which_square_occupied
      end
    end
    @squares = current_state_of_board
    return moves_that_result_in_check.all? true
  end

  def check_pawn_promotion(piece, end_location, colour)
    if piece.type == 'pawn' && (end_location[1] == 0 || end_location[1] == 7)
      loop do
        puts "Choose which piece your pawn will be promoted to"
        new_type = gets.chomp
        if new_type == "rook" || new_type == "knight" || new_type == "queen" || 
          new_type == "bishop"
          set_piece(end_location, new_type, colour)
          break
        end
      end
    end
  end
end