# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2657" : "\u265D"
  end
end