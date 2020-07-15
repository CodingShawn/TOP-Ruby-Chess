require_relative 'board'
require 'yaml'

class Game
  attr_reader :turn
  
  def initialize(board = Board.new, turn = "white", other_player = "black")
    @board = board
    @turn = turn
    @other_player = other_player
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
        input = gets.chomp
        if input == "save"
          save_game
          puts "Its #{@turn} turn to make a move"
          input = gets.chomp
          break
        elsif input == "load"
          load_game
          puts "Its #{@turn} turn to make a move"
          input = gets.chomp
          break
        end
        move = input.split("")
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

  def save_game
    save_string = YAML.dump ({
      :board => @board,
      :turn => @turn,
      :other_player => @other_player
    })
    save_file = File.open("../save.txt", "w")
    save_file.puts save_string
    puts "Game has been saved!"
  end

  def load_game
    saved_game = File.open("../save.txt", "r")
    saved_string = saved_game.read 
    data = YAML.load saved_string
    @board = data[:board]
    @turn = data[:turn]
    @other_player = data[:other_player]
    puts "Game loaded!"
    @board.draw_board
  end
end

Game.new