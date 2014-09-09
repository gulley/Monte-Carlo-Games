%% Imminent Defeat Short-Circuit
% Black plays to block

g = ConnectFour;
g.boardstate = zeros(6,7);
g.boardstate(6,:) = [1 1 1 0 2 0 2];
g.showBoard
assert(g.whoseMove==2)
gamebotMoves(g,1)
assert(g.boardstate(6,4)==2)

%% Imminent Victory Short-Circuit
% Red plays to win

g = ConnectFour;
g.boardstate = zeros(6,7);
g.boardstate(6,:) = [2 1 1 1 0 2 2];
g.showBoard
assert(g.whoseMove==1)
gamebotMoves(g,1)
assert(g.boardstate(6,5)==1)

%% Test Possible Moves

g = ConnectFour;
g.boardstate = zeros(6,7);
g.boardstate(:,1) = [2;1;2;1;2;1];
g.boardstate(:,7) = [2;1;2;1;2;1];
g.boardstate(:,4) = [2;1;2;1;2;1];
g.showBoard
assert(g.whoseMove==1)
moves = g.possibleMoves;
assert(isequal(moves,[2 3 5 6]))

%% Speed Round

g = ConnectFour;

% Two robots play until the game is over
nGamesSide1 = 1;
nGamesSide2 = 1;
while ~g.isGameOver
    gamebotMoves(g,nGamesSide1);
    
    if ~g.isGameOver
        gamebotMoves(g,nGamesSide2);
    end
end

