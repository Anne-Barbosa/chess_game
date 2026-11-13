# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2659" : "\u265F"
  end

  def valid_move?(start_pos, end_pos)
    start_row, start_col = start_pos
    end_row, end_col = end_pos

    row_diff = end_row - start_row
    col_diff = (end_col - start_col).abs

    direction = color == :white ? -1 : 1
    start_row_line = color == :white ? 6 : 1

    return true if row_diff == direction && col_diff.zero?

    return true if row_diff == (2 * direction) && col_diff.zero? && start_row == start_row_line

    return true if row_diff == direction && col_diff == 1

    false
  end
end
