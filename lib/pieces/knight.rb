# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2658" : "\u265E"
  end

  def valid_move?(start_pos, end_pos)
    start_row, start_col = start_pos
    end_row, end_col = end_pos

    row_diff = (end_row - start_row).abs
    col_diff = (end_col - start_col).abs

    (row_diff == 2 && col_diff == 1) || (row_diff == 1 && col_diff == 2)
  end
end
