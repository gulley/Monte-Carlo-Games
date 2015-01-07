%% Tic Tac Toe Demo
% Initialize
g = TicTacToe;
g.showBoard

%
% Two robots play until the game is over
nGames1 = 1000;
nGames2 = 1000;
while ~g.isGameOver
    gamebotMoves(g,nGames1);
        
    if ~g.isGameOver
        gamebotMoves(g,nGames2);
    end
end


%%
g = TicTacToe;

%%

gamebotMoves(g,200);

