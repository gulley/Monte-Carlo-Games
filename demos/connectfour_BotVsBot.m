%% Connect Four Robot vs. Robot
% Initialize

gameType = 4;
switch gameType
    case 1
        g = ConnectFour;
    case 2
        g = ConnectEl;
    case 3
        g = ConnectTee;
    case 4
        g = FourCorners;
end

g.showResult

% Two robots play until the game is over
nGamesSide1 = 200;
nGamesSide2 = 200;
while ~g.isGameOver
    botMoves(g,nGamesSide1);
    
    if ~g.isGameOver
        botMoves(g,nGamesSide2);
    end
end
