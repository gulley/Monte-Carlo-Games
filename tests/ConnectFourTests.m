%% Imminent Defeat Short-Circuit
% Black plays to block

g = ConnectFour;
g.board = zeros(6,7);
g.board(6,:) = [1 1 1 0 2 0 2];
g.showBoard
assert(g.whoseMove==2)
botMoves(g,1000)
assert(g.board(6,4)==2)

%% Test Possible Moves

g = ConnectFour;
g.board = zeros(6,7);
g.board(:,1) = [2;1;2;1;2;1];
g.board(:,7) = [2;1;2;1;2;1];
g.board(:,4) = [2;1;2;1;2;1];
g.showBoard
assert(g.whoseMove==1)
moves = g.possibleMoves;
assert(isequal(moves,[2 3 5 6]))

%% Speed Round Connect Four

g = ConnectFour;

% Two robots play until the game is over
nGamesSide1 = 1;
nGamesSide2 = 1;
while ~g.isGameOver
    botMoves(g,nGamesSide1);
    
    if ~g.isGameOver
        botMoves(g,nGamesSide2);
    end
end


