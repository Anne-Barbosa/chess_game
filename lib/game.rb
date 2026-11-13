# frozen_string_literal: true

require 'json'
require_relative 'board'
require_relative 'pieces/piece'

class Game
  SAVE_FILE = 'bin/chess_save.dat'

  attr_reader :board, :current_player

  def initialize(board = Board.new, current_player = :white)
    @board = board
    @current_player = current_player
  end

  def switch_turn
    @current_player = @current_player == :white ? :black : :white
  end

  def valid_turn?(coords)
    piece = @board.piece_at(coords)

    return false if piece.nil? || piece == ' '

    piece.color == @current_player
  end

  def play
    loop do
      @board.display

      puts "⚠️ ATTENTION: King #{@current_player.to_s.capitalize} is in CHECK!" if @board.in_check?(@current_player)

      puts "#{@current_player.to_s.capitalize}'s turn. Enter move (e.g., e2 e4) or type 'save':"

      print 'From: '
      start_str = gets.chomp.downcase.strip

      if start_str == 'save'
        save_game
        next
      end

      print 'To: '
      end_str = gets.chomp.downcase.strip

      start_pos = @board.algebraic_to_coords(start_str)
      end_pos = @board.algebraic_to_coords(end_str)

      if start_pos && end_pos && valid_turn?(start_pos) && @board.move(start_pos, end_pos)
        opponent_color = @current_player == :white ? :black : :white

        if @board.checkmate?(opponent_color)
          @board.display
          puts "\n🏁 CHECKMATE! Game over. The winner is #{@current_player.to_s.capitalize}!"
          break
        end

        switch_turn
      else
        puts "It's not a legal move! Try again!"
      end
    end
  end

  private

  def save_game
    Dir.mkdir('bin') unless Dir.exist?('bin')

    File.binwrite(SAVE_FILE, Marshal.dump(self))
    puts "\nGame successfully saved to #{SAVE_FILE}!"
  end

  def self.load_game
    unless File.exist?(SAVE_FILE)
      puts 'No saved game found.'
      return nil
    end

    game = Marshal.load(File.binread(SAVE_FILE))
    puts 'Game loaded successfully!'
    sleep(1)

    game
  rescue JSON::ParserError
    puts 'Save file is corrupted.'
    nil
  end
end
