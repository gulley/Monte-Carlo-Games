%% Tic Tac Toe Demo
% Initialize
g = TicTacToe;
g.showResult

% Two robots play until the game is over
while ~g.isGameOver
    gamebotMoves(g,200);
    snapnow
    
    if ~g.isGameOver
        gamebotMoves(g,200);
        snapnow
    end
end
