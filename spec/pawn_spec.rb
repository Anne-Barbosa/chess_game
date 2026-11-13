# frozen_string_literal: true

require_relative '../lib/pieces/pawn'

describe Pawn do
  describe '#valid_move?' do
    context "when it's a white pawn" do
      let(:pawn) { Pawn.new(:white) }

      it 'returns true for valid forward moves and diagonal captures' do
        expect(pawn.valid_move?([6, 3], [4, 3])).to be true
        expect(pawn.valid_move?([6, 3], [5, 4])).to be true
      end

      it 'returns false for backward moves' do
        expect(pawn.valid_move?([6, 3], [7, 3])).to be false
      end
    end

    context "when it's a black pawn" do
      let(:pawn) { Pawn.new(:black) }

      it 'returns true for valid forward moves and diagonal captures' do
        expect(pawn.valid_move?([1, 3], [3, 3])).to be true
        expect(pawn.valid_move?([1, 3], [2, 4])).to be true
      end

      it 'returns false for backward moves' do
        expect(pawn.valid_move?([1, 3], [0, 3])).to be false
      end
    end
  end
end
