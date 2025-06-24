%% Reversi Demo
% Initialize

game = Reversi;
game.showBoard

% You play the robot
nGamesSide = 100;

%%

move = 8;
iMove(game,move,1)

if ~game.isGameOver
    botMoves(game,nGamesSide);
end
