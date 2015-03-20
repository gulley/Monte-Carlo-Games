%% Connect Four Robot vs. Robot
% Initialize

gameType = 4;
switch gameType
    case 1
        game = ConnectFour;
    case 2
        game = ConnectEl;
    case 3
        game = ConnectTee;
    case 4
        game = FourCorners;
end

game.showResult

% Two robots play until the game is over
nGamesSide1 = 1000;
nGamesSide2 = 1000;
while ~game.isGameOver
    botMoves(game,nGamesSide1);
    
    if ~game.isGameOver
        botMoves(game,nGamesSide2);
    end
end
