%% Reversi Demo
% Initialize

game = Reversi;
game.showBoard

% Two robots play until the game is over
nGamesSide1 = 20;
nGamesSide2 = 20;

while ~game.isGameOver
    botMoves(game,nGamesSide1);
    
    if ~game.isGameOver
        botMoves(game,nGamesSide2);
    end
        
end
