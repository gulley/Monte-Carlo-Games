%% Hex Demo
% You play robot against robot like this.

%% Initialize
g = Hex
g.showBoard

%%
% Use this code to watch the robot play against itself.

% Repeat this command until one side wins or there's a tie.
while ~g.isGameOver
    autoMove(g);
    g.showResult;
    snapnow
end

%%
% Use this code to play against the robot

% g.makeMove(21);
% g.showResult;
% drawnow
% 
% if ~g.isGameOver
%     autoMove(g);
%     g.showResult;
% end
