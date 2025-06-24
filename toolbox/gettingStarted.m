%% Getting Started with Monte Carlo Games
% This is an introduction to the Monte Carlo Games toolbox, which implements
% strategy-free robot board games using Monte Carlo simulation for move evaluation.

%% Setup
% Initialize the toolbox path to access all games and functions
addpath(genpath(fileparts(mfilename('fullpath'))))

%% What are Monte Carlo Games?
% Instead of implementing complex game strategies, these AI players evaluate 
% potential moves by simulating thousands of random games and selecting the 
% move with the highest probability of winning or drawing.

%% Available Games
% The toolbox includes several classic board games:
%
% * *Connect Four* - Classic 4-in-a-row on a 6x7 grid
% * *Connect El* - Variant requiring L-shaped patterns  
% * *Connect Tee* - T-shaped victory condition
% * *Four Corners* - Connect the four corners (losing condition)
% * *Tic-Tac-Toe* - Traditional 3x3 grid
% * *Oxo* - Reverse tic-tac-toe where creating "OXO" pattern wins
% * *Reversi* - Classic piece-flipping strategy game

%% Quick Start: Play Connect Four
% Create a new Connect Four game and let the bot make a move

game = ConnectFour;
game.showBoard

% Let the bot make a move using 1000 Monte Carlo simulations
botMoves(game, 1000)

%% Interactive Play: Human vs Bot
% You can play against the bot using the iMove function

% Create a new Tic-Tac-Toe game
game = TicTacToe;
game.showBoard

% Make your move (position 5 = center, side 1 = X)
iMove(game, 5, 1)

% Let the bot respond
botMoves(game, 100)

%% Bot vs Bot: Watch AI Players Compete
% Set up two bots to play against each other

game = TicTacToe;

while ~game.isGameOver
    % Player 1 (X) move
    botMoves(game, 100)
    
    if ~game.isGameOver
        % Player 2 (O) move  
        botMoves(game, 100)
    end
end

% Display the final result
if game.isGameOver == 1
    fprintf('X wins!\n')
elseif game.isGameOver == 2
    fprintf('O wins!\n')
else
    fprintf('Draw!\n')
end

%% Monte Carlo Parameters
% The second parameter to botMoves() controls the number of simulations:
%
% * *Low (10-100)*: Fast but less strategic moves
% * *Medium (100-1000)*: Good balance of speed and strategy  
% * *High (1000+)*: Best strategy but slower computation

%% Understanding Game Mechanics
% All games follow a common interface:
%
% * |possibleMoves()| - Returns available move positions
% * |makeMove(pos, side)| - Execute a move
% * |whoseMove()| - Returns which player's turn (1 or 2)
% * |isGameOver()| - Returns 0 (ongoing), 1 (side 1 wins), 2 (side 2 wins), 3 (draw)
% * |showBoard()| - Display current game state
% * |copy()| - Create independent copy for simulation

%% Advanced Usage: Custom Game Analysis
% You can analyze specific game positions by setting up the board manually

game = ConnectFour;
% Set up a specific board position
game.board(6, [1 2 3]) = 1;  % Red pieces on bottom row
game.board(5, [1 2]) = 2;    % Black pieces on second row
game.showBoard

% Analyze the position with high-precision Monte Carlo
fprintf('Analyzing position with 5000 simulations...\n')
botMoves(game, 5000)

%% Next Steps
% * Explore the demos/ folder for more examples
% * Try different games and Monte Carlo parameters
% * Experiment with custom board positions
% * Read the documentation for individual game rules

fprintf('Getting Started tutorial complete!\n')
fprintf('Try running different demos or create your own games.\n')