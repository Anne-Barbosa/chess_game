# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2658" : "\u265E"
  end
end