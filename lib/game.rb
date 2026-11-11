# frozen_string_literal: true

require_relative 'board'
require_relative 'pieces/piece'

class Game
  attr_reader :board, :current_player

  def initialize(board = Board.new)
    @board = board
    @current_player = :white 
  end

  def switch_turn
    @current_player = (@current_player == :white) ? :black : :white
  end

  def valid_turn?(coords)
    piece = @board.piece_at(coords)

    return false if piece.nil? || piece == ' '

    piece.color == @current_player
  end

  def play
    loop do
      @board.display

      puts "#{@current_player.to_s.capitalize}'s turn. Enter move (e.g., e2 e4):"
      
      print "From: "
      start_str = gets.chomp
      print "To: "
      end_str = gets.chomp

      start_pos = @board.algebraic_to_coords(start_str)
      end_pos = @board.algebraic_to_coords(end_str)

      if start_pos && end_pos && valid_turn?(start_pos) && @board.move(start_pos, end_pos)
        switch_turn
      else
        puts "It's not a legal move! Try again!"
      end
    end
  end
end