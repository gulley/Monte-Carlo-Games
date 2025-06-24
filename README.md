# Monte Carlo Games

A MATLAB implementation of strategy-free robot board games using Monte Carlo simulation for move evaluation.

## Overview

This repository contains a collection of classic board games where AI players use Monte Carlo methods to make decisions. Instead of implementing complex game strategies, the robots evaluate potential moves by simulating thousands of random games and selecting the move with the highest probability of winning or drawing.

## Supported Games

- **Connect Four** - Classic 4-in-a-row on a 6x7 grid
- **Connect El** - Variant requiring 4 corners of a rectangle
- **Connect Tee** - T-shaped victory condition
- **Four Corners** - Connect the four corners of the board
- **Tic-Tac-Toe** - Traditional 3x3 grid
- **Oxo** - Reverse tic-tac-toe where creating "OXO" pattern wins
- **Reversi** - Classic piece-flipping strategy game

## Quick Start

1. Open MATLAB and navigate to the repository directory
2. Add the toolbox to your path:
   ```matlab
   addpath('toolbox')
   addpath('toolbox/games')
   ```
3. Get started with the interactive tutorial:
   ```matlab
   gettingStarted
   ```
4. Or try a demo:
   ```matlab
   % Bot vs Bot Connect Four
   run('demos/connectfour_BotVsBot.m')
   
   % Human vs Bot Tic-Tac-Toe
   run('demos/tictactoe_PlayerVsBot.m')
   ```

## How It Works

The Monte Carlo approach evaluates each possible move by:
1. Making the move on a copy of the current board
2. Playing N random games from that position
3. Counting wins, losses, and draws
4. Selecting the move that maximizes (wins + draws)

Example usage:
```matlab
game = ConnectFour;
botMoves(game, 1000);  % Bot makes move after 1000 simulations
```

## Architecture

- **Game Classes**: Each game inherits from `FourGameBase` or `handle`
- **Bot Engine**: `botMoves()` function handles Monte Carlo evaluation
- **Interactive Play**: `iMove()` helper for human moves
- **Visualization**: Real-time board display with move suggestions

## Testing

Run the comprehensive test suite:
```matlab
cd tests
run('RunAllTests.m')
```

Or run individual test classes:
```matlab
runtests('TicTacToeTests')
```

## Learn More

Read the original blog post: [Robot Game Playing in MATLAB](http://blogs.mathworks.com/community/2015/01/09/robot-game-playing-in-matlab/)
