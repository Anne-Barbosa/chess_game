# frozen_string_literal: true

require_relative '../lib/pieces/queen'

describe Queen do
  describe "#valid_move?" do
    let(:queen) { Queen.new(:white) }

    it "it returns true for valid moves" do
      expect(queen.valid_move?([4, 3], [3, 3])).to be true
      expect(queen.valid_move?([4, 3], [4, 4])).to be true
      expect(queen.valid_move?([4, 3], [5, 3])).to be true
      expect(queen.valid_move?([4, 3], [3, 2])).to be true
    end

    it "it returns false for invalid moves" do
      expect(queen.valid_move?([4, 3], [3, 5])).to be false
      expect(queen.valid_move?([4, 3], [6, 2])).to be false
    end
  end
end
