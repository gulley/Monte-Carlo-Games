%% Reversi Demo
% Initialize

game = Reversi;
game.showResult

% You play the robot
nGamesSide = 20;

%%

move = 18;
iMove(game,move,2)

if ~game.isGameOver
    botMoves(game,nGamesSide);
end
