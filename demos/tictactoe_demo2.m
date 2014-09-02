%% Tic Tac Toe Demo
% Initialize
g = TicTacToe;
g.showResult

%%
% Play until one side wins or there's a tie.
while ~g.isGameOver
    gamebotMoves(g,100);
    snapnow
    
    if ~g.isGameOver
        gamebotMoves(g,10);
        snapnow
    end
end
