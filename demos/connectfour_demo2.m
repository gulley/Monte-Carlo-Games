%% Connect Four Demo
% Initialize

% g = ConnectFour;
g = ConnectEl;
% g = FourCorners;
g.showResult

%%
% Use this code to play against the robot

iMove(g,1,2);
drawnow

%%

if ~g.isGameOver
    gamebotMoves(g,200);
end

