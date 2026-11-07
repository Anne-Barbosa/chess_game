# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { Game.new }

  describe "#initialize" do
    it "starts with white as the current player turn" do
      expect(game.current_player).to eq(:white)
    end
  end

  describe "#switch_turn" do
    it "switches the turn from white to black" do
      game.switch_turn
      expect(game.current_player).to eq(:black)
    end

    it "switches the turn back from black to white" do
      game.switch_turn # vai para black
      game.switch_turn # volta para white
      expect(game.current_player).to eq(:white)
    end
  end

  describe "valid_turn?" do
    it "returns true when the current player tries to move their own piece" do
      white_pawn_pos = [6, 4]
      expect(game.valid_turn?(white_pawn_pos)).to be true
    end

    it "returns false when the current player tries to move the opponent's piece" do
      black_pawn_pos = [1, 4]
      expect(game.valid_turn?(black_pawn_pos)).to be false
    end
  end
end
