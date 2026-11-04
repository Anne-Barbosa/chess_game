# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2654" : "\u265A"
  end
end