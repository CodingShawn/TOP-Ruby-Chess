require_relative 'board'
require 'pry'

class Game
  attr_reader :turn
  def initialize
    @board = Board.new
    @turn = "white"
    @board.draw_board
    play_game
  end

  def play_game
    loop do
      if make_move
        break
      end
    end
    @board.draw_board
  end

  def make_move
    puts "Its #{@turn} turn to make a move"
    loop do
      begin
        move = gets.chomp.split("")
        start_location = [move[1].to_i, convert_letter_to_int(move[0])]
        end_location = [move[4].to_i, convert_letter_to_int(move[3])]
        @board.move_piece(start_location, end_location, @turn)
        break
      rescue
        puts "Please input move in chess notation format e.g. h5 g1"
      end
    end 
  end

  def convert_letter_to_int(letter)
    case letter
    when "a"
      0
    when "b"
      1
    when "c"
      2
    when "d"
      3
    when "e"
      4
    when "f"
      5
    when "g"
      6
    when "h"
      7
    end
  end

  def change_turn
    if @turn.eql? "white"
      @turn = "black"
    else
      @turn = "white"
    end
  end
end

Game.new