%% Reversi Demo
% Initialize

game = Reversi;
game.showBoard

% Two robots play until the game is over
nGamesSide1 = 10;
nGamesSide2 = 10;

while ~game.isGameOver
    botMoves(game,nGamesSide1);
    
    if ~game.isGameOver
        botMoves(game,nGamesSide2);
    end
        
end
