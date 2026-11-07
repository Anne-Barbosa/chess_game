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
end