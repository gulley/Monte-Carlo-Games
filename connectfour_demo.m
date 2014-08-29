%% Connect Four Demo
% Initialize

% g = ConnectFour;
g = ConnectEl;
% g = ConnectFourCorners;
g.showResult

%%
% Play until one side wins or there's a tie.
while ~g.isGameOver
    gamebotMoves(g,100);
    snapnow
    
    if ~g.isGameOver
        gamebotMoves(g,100);
        snapnow
    end
end

%%
% Use this code to play against the robot

iMove(g,1,2);
drawnow

%

if ~g.isGameOver
    gamebotMoves(g,200);
end

