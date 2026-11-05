# frozen_string_literal: true

require_relative '../lib/pieces/knight'

describe Knight do
  describe "#valid_move?" do
    let(:knight) { Knight.new(:white) }

    it "returns true for valid L-shape moves" do
      expect(knight.valid_move?([1, 1], [3, 2])).to be true
      expect(knight.valid_move?([1, 1], [2, 3])).to be true
    end

    it "returns false for invalid moves" do
      move = Knight.new([1, 1])

      expect(knight.valid_move?([1, 1], [1, 3])).to be false
      expect(knight.valid_move?([1, 1], [1, 1])).to be false
      expect(knight.valid_move?([1, 1], [3, 3])).to be false
    end
  end
end
