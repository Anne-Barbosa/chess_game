# Ruby CLI Chess Game

A fully-featured, object-oriented command-line Chess game built in Ruby as the capstone project for [The Odin Project](https://www.theodinproject.com/) Ruby curriculum. 

This project emphasizes clean code architecture, Test-Driven Development (TDD) using RSpec, modular design, and robust game state serialization.

---

## Features

- **Two-Player CLI Experience**: Play a complete game of chess locally in the terminal with intuitive algebraic notation inputs (`e2 e4`).
- **Full Rule Enforcement**: 
  - Geometric movement validation for all piece types (Pawn, Rook, Knight, Bishop, Queen, King).
  - Path-blocking and ally-capture protection.
  - Complete **Check** and **Checkmate** detection algorithms that prevent illegal moves leaving the King in danger.
- **Game Persistence (Save/Load)**: Save your match at any point during your turn using `save` and seamlessly resume later using Ruby's native `Marshal` serialization.
- **RSpec Test Suite**: Comprehensive unit tests ensuring core board logic, piece movements, and checkmate conditions remain bulletproof.

---

## Project Architecture

The codebase follows strict Object-Oriented Programming (OOP) and Single Responsibility Principles (SRP):

- **`Board`**: Manages the grid matrix, piece positions, path clearance, and game state rules (checks and checkmates).
- **`Game`**: Handles the terminal input/output loop, player turns, and persistence (`save`/`load`).
- **`Piece` Subclasses**: Encapsulate individual movement behaviors and valid vectors for Rooks, Knights, Bishops, Queens, Kings, and Pawns.

---

## Getting Started

### Prerequisites

Make sure you have **Ruby** installed on your system (developed and tested with Ruby 3.4.x).

### Installation

1. Clone the repository:
   ```bash
   git clone [https://github.com/YOUR_USERNAME/chess-game.git](https://github.com/YOUR_USERNAME/chess-game.git)
   cd chess-game
   ```
2. Run the test suite to verify everything is green:
    ```bash
    bundle exec rspec
    ```
3. Launch the game:
    ```bash
    ruby bin/main.rb
    ```
## How to Play

1. Run ruby bin/main.rb.
2. Choose 1 to start a new game or 2 to load a previously saved match.
3. When prompted, enter your move using standard algebraic notation coordinates (e.g., From: e2 -> To: e4).
4. Type save at any prompt to save your current game state to bin/chess_save.dat.

## License

This project is open-source and available under the MIT License.