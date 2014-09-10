%% Reversi Demo
% Initialize

g = Reversi;
g.showResult

% You play the robot
nGamesSide2 = 50;

%%

move = 35;
g.makeMove(move,1)
g.showResult

if ~g.isGameOver
    gamebotMoves(g,nGamesSide2);
end
