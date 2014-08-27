%% Connect Four Demo
% You play robot against robot like this.

%% Initialize
% g = ConnectFour
g = ConnectEl;
g.showBoard

%%
% Use this code to watch the robot play against itself
while ~g.isGameOver
    autoMove(g);
    g.showResult;
    snapnow
end

%%
% Use this code to play against the robot

g.makeMove(3);
g.showResult;
drawnow

if ~g.isGameOver
    autoMove(g);
    g.showResult;
end
