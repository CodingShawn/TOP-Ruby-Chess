require_relative 'piece'

class Pawn < Piece
  def initialize(location, colour)
    super(location, colour)
    @type = "pawn"
  end

  def possible_moves(occupied_squares, opposing_pieces)
    opposing_pieces_location = opposing_pieces.map {|piece| piece.location}
    if @colour == "black"
      result = [[@column, @row + 1]] #allow forward movement by 1 square
      if @row == 1
        result.append [@column, @row + 2] #allow forward movement by 2 squares if at start location
      end
      result -= occupied_squares #prevent pawn from eating by moving forward
      possible_attack_moves = [[@column + 1, @row + 1], [@column -1, @row + 1]]
      result += possible_attack_moves.filter do |possible_attack_move|
        opposing_pieces_location.include? possible_attack_move
        #allow pawn to eat opposing piece diagonally
      end
    else
      result = [[@column, @row - 1]]
      if @row == 6
        result.append [@column, @row - 2]  
      end
      result -= occupied_squares
      possible_attack_moves = [[@column + 1, @row - 1], [@column -1, @row - 1]]
      result += possible_attack_moves.filter do |possible_attack_move|
        opposing_pieces_location.include? possible_attack_move
      end
    end
    prevent_off_board_moves(result)
  end

  def to_s
    unicode = ""
    if @colour == "black"
      unicode = "\u2659"
    else
      unicode = "\u265F"
    end
    unicode.encode('utf-8')
  end
end
