%% Connect Four Demo
% Initialize

% g = ConnectFour;
g = ConnectEl;
g.showResult

%%
% Play until one side wins or there's a tie.
while ~g.isGameOver
    gamebotMoves(g,10);
    snapnow
    
    if ~g.isGameOver
        gamebotMoves(g,200);
        snapnow
    end
end

%%
% Use this code to play against the robot

iMove(g,6,1);
drawnow

if ~g.isGameOver
    gamebotMoves(g,10);
end

