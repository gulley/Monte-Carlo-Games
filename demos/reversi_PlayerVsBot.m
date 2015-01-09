%% Reversi Demo
% Initialize

g = Reversi;
g.showResult

% You play the robot
nGamesSide = 20;

%%

move = 18;
iMove(g,move,2)

if ~g.isGameOver
    botMoves(g,nGamesSide);
end
