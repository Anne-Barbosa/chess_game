# frozen_string_literal: true

require_relative 'pieces/piece'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'pieces/pawn'

class Board
  attr_accessor :grid

  def initialize
    @rows = 8
    @columns = 8
    @grid = Array.new(@rows) { Array.new(@columns, ' ') }
    setup_board
  end

  def setup_board
    back_row_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    back_row_pieces.each_with_index do |piece_class, col|
      @grid[0][col] = piece_class.new(:black)
      @grid[1][col] = Pawn.new(:black)
    end

    back_row_pieces.each_with_index do |piece_class, col|
      @grid[6][col] = Pawn.new(:white)
      @grid[7][col] = piece_class.new(:white)
    end
  end

  def piece_at(coords)
    row = coords[0]
    col = coords[1]
    @grid[row][col]
  end
end