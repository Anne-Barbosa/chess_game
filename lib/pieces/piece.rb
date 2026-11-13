# frozen_string_literal: true

class Piece
  attr_reader :color, :symbol

  def initialize(color)
    @color = color
  end
end
