require_relative 'board'
require 'pry'

class Game
  attr_reader :turn
  def initialize
    @board = Board.new
    @turn = "black"
    @other_player = "white"
    @board.draw_board
    play_game
  end

  def play_game
    loop do
      loop do
        if make_move
          break
        end
        puts "That move is illegal"
      end
      @board.draw_board
      change_turn
      #change turn first as initially check_move_results_in_check method tests 
      #if own moves results in own check
      if @board.check_if_move_results_in_check(@turn)
        if @board.check_if_checkmake(@other_player)
          puts "Game is over, #{@turn} has been checkmated!"
          puts "The #{@other_player} has won!"
          break
        end
        puts "#{@other_player} has checked #{@turn}"
      end
    end
  end

  def make_move
    puts "Its #{@turn} turn to make a move"
    loop do
      begin
        move = gets.chomp.split("")
        start_location = [convert_letter_to_int(move[0]), 8 - move[1].to_i] 
        #used 8 -move[x] so that command from player will be auto translated to correct array represented on board
        end_location = [convert_letter_to_int(move[3]), 8 - move[4].to_i]
        made_move = @board.move_piece(start_location, end_location, @turn)
        return made_move
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
      @other_player = "white"
    else
      @turn = "white"
      @other_player = "black"
    end
  end
end

Game.new