# frozen_string_literal: true

require_relative 'pieces/piece'
require_relative 'pieces/rook'
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
    @grid[0][0] = Rook.new(:black)
    @grid[6] = Array.new(8) { Pawn.new(:white) }
  end

  def piece_at(coords)
    row = coords[0]
    col = coords[1]
    @grid[row][col]
  end
end