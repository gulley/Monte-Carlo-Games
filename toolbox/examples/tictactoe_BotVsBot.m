%% TicTacToe Demo
% Initialize

game = TicTacToe;
game.showBoard

% Two robots play until the game is over
nGamesSide1 = 1000;
nGamesSide2 = 1000;

while ~game.isGameOver
    botMoves(game,nGamesSide1);
    
    if ~game.isGameOver
        botMoves(game,nGamesSide2);
    end
        
end
