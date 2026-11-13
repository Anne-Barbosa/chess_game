# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2656" : "\u265C"
  end

  def valid_move?(start_pos, end_pos)
    start_row, start_col = start_pos
    end_row, end_col = end_pos

    row_diff = (end_row - start_row).abs
    col_diff = (end_col - start_col).abs

    (row_diff.zero? && col_diff.positive?) || (col_diff.zero? && row_diff.positive?)
  end
end
