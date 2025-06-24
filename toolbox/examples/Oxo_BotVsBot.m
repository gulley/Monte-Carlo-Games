%% OXO Demo
% Initialize

game = Oxo;
game.showBoard
% Two robots play until the game is over
nGamesSide1 = 100;
nGamesSide2 = 100;

while ~game.isGameOver
    botMoves(game,nGamesSide1);
    
    if ~game.isGameOver
        botMoves(game,nGamesSide2);
    end
        
end

