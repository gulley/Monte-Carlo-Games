%% Connect Four Demo
% Initialize

% g = ConnectFour;
g = ConnectEl
% g = FourCorners;
g.showResult

% Two robots play until the game is over
while ~g.isGameOver
    gamebotMoves(g,10);
    snapnow
    
    if ~g.isGameOver
        gamebotMoves(g,10);
        snapnow
    end
end
