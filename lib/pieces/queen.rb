# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2655" : "\u265B"
  end

  def valid_move?(start_pos, end_pos)
    start_row, start_col = start_pos
    end_row, end_col = end_pos

    row_diff = (end_row - start_row).abs 
    col_diff = (end_col - start_col).abs

    (row_diff == col_diff && row_diff > 0) ||
    (row_diff == 0 && col_diff > 0) ||
    (col_diff == 0 && row_diff > 0)
  end
end