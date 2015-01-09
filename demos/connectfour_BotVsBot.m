%% Connect Four Robot vs. Robot
% Initialize

gameType = 1;
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
nGamesSide1 = 200;
nGamesSide2 = 200;
while ~game.isGameOver
    botMoves(game,nGamesSide1);
    
    if ~game.isGameOver
        botMoves(game,nGamesSide2);
    end
end
