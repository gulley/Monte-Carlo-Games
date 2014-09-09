%% Connect Four Demo
% Initialize

% g = ConnectFour;
g = ConnectEl;
% g = FourCorners;
g.showResult

% Two robots play until the game is over
nGamesSide1 = 200;
nGamesSide2 = 200;
while ~g.isGameOver
    gamebotMoves(g,nGamesSide1);
    
    if ~g.isGameOver
        gamebotMoves(g,nGamesSide2);
    end
end
