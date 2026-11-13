# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2654" : "\u265A"
  end

  def valid_move?(start_pos, end_pos)
    start_row, start_col = start_pos
    end_row, end_col = end_pos

    row_diff = (end_row - start_row).abs
    col_diff = (end_col - start_col).abs

    row_diff <= 1 && col_diff <= 1 && (row_diff.positive? || col_diff.positive?)
  end
end
