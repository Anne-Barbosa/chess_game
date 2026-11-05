# frozen_string_literal: true

require_relative '../lib/pieces/bishop'

describe Bishop do
  describe "#valid_move?" do
    let(:bishop) { Bishop.new(:white) }

    it "returns true for valid moves" do
      expect(bishop.valid_move?([4, 3], [5, 4])).to be true
      expect(bishop.valid_move?([4, 3], [5, 2])).to be true
    end

    it "returns false for invalid moves" do
      expect(bishop.valid_move?([4, 3], [4, 4])).to be false
      expect(bishop.valid_move?([4, 3], [5, 3])).to be false
    end
  end
end
