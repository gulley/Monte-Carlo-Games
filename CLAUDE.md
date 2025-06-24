# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a MATLAB-based Monte Carlo game-playing system that implements various board games with strategy-free robot players. The robots use Monte Carlo simulation to evaluate potential moves by playing thousands of random games from each possible position.

## Setup

**Essential first step**: Add toolbox to MATLAB path or use the provided initialization:
```matlab
% Quick setup
addpath('toolbox')
addpath('toolbox/games')

% Or use the comprehensive setup
addpath('toolbox/internal')
initializePath()
```

**Getting started**: Run the interactive tutorial:
```matlab
gettingStarted
```

## Key Architecture

### Game Class Hierarchy
- **FourGameBase**: Base class for 6x7 grid games (Connect Four, Connect El, Four Corners, etc.)
- **Individual game classes**: Each game implements specific victory conditions and board display logic
- **Common interface**: All games implement `possibleMoves()`, `makeMove()`, `whoseMove()`, `isGameOver()`, `showBoard()`, and `copy()`

### Monte Carlo Bot System
- **botMoves()**: Main bot decision-making function in `botMoves.m`
- **Strategy**: For each possible move, simulates `nGames` random games and picks the move with highest win+draw probability
- **Evaluation**: Uses `ratePossibleMoves()` to score each potential move
- **Fallback**: Handles edge cases (no moves, single move available)

### Core Functions
- **botMoves(game, nGames)**: Main bot move selection (in `toolbox/`)
- **iMove(game, pos, side)**: Interactive move helper for human players (in `toolbox/`)
- **gettingStarted.m**: Interactive tutorial for new users (in `toolbox/`)
- **initializePath.m**: Sets up MATLAB path for the project (in `toolbox/internal/`)

## Running Tests

### Unit Test Framework
All tests use MATLAB's `matlab.unittest.TestCase` framework for professional test organization.

**Run all tests:**
```matlab
cd tests
run('RunAllTests.m')
```

**Run specific test class:**
```matlab
runtests('TicTacToeTests')
```

**Run from project root:**
```matlab
runtests('tests')
```

Tests include comprehensive coverage of constructors, game logic, victory conditions, bot integration, and edge cases.

## Common Development Patterns

### Creating New Games
1. Inherit from `FourGameBase` (for 6x7 games) or `handle` (for other board sizes)
2. Implement required methods: `copy()`, `isGameOver()`, `possibleMoves()`, `makeMove()`, `whoseMove()`, `showBoard()`
3. Use convolution (`conv2`) for pattern matching in victory conditions
4. Follow existing naming conventions (class names match file names)

### Bot vs Bot Demos
Located in `demos/` - use pattern:
```matlab
game = GameClass;
while ~game.isGameOver
    botMoves(game, nGames);
    if ~game.isGameOver
        botMoves(game, nGames);
    end
end
```

### Player vs Bot Demos
Use `iMove(game, position, side)` for human moves and `botMoves(game, nGames)` for bot moves.

## Monte Carlo Performance Guidelines

- **Fast testing**: Use `nGames = 1` for quick debugging and development
- **Standard gameplay**: Use `nGames = 100-1000` for reasonable bot strength
- **Strong gameplay**: Use `nGames = 1000+` for stronger moves (slower)
- **Bot strategy**: Maximizes `(wins + draws)` rather than just wins

## Game-Specific Notes

- **Connect Four family**: Uses `FourGameBase`, pieces drop to bottom of columns
- **TicTacToe/Oxo**: Uses linear indexing for 3x3 or NxN boards
- **Reversi**: Different board size and piece-flipping mechanics
- **Games in development**: Located in `games_in_development/`

## Side Conventions

- **Side 1**: First player (Red pieces in Connect Four family, X in tic-tac-toe variants)
- **Side 2**: Second player (Black pieces in Connect Four family, O in tic-tac-toe variants)
- **Turn determination**: `whoseMove()` returns 1 or 2 based on number of pieces on board
- **Game results**: `isGameOver()` returns 0 (ongoing), 1 (side 1 wins), 2 (side 2 wins), 3 (draw)

## Visualization

All games use MATLAB's plotting system with:
- Grid-based display using `line()` and `text()` objects
- Color-coded pieces (red/black for most games, X/O for tic-tac-toe variants)
- Move numbers or Monte Carlo ratings displayed on available positions
- Real-time board updates with `showBoard()` method