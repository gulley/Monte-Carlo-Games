%% Tic Tac Toe Demo
% Initialize
g = TicTacToe;
g.showBoard

% Two robots play until the game is over
nGames1 = 1000;
nGames2 = 1000;
while ~g.isGameOver
    botMoves(g,nGames1);
    snapnow
    
    if ~g.isGameOver
        botMoves(g,nGames2);
    end
    snapnow
    
end

