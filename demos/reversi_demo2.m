%% Reversi Demo
% Initialize

g = Reversi;
g.showResult

% You play the robot
nGamesSide2 = 20;

%%

move = 18;
iMove(g,move,2)

if ~g.isGameOver
    gamebotMoves(g,nGamesSide2);
end
