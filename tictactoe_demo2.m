%% Tic Tac Toe Demo
% You play robot against robot like this.

%% Initialize
g = game
g.displayBoard

%%
% Repeat this command until one side wins or there's a tie.
while ~g.isOver
    g = autoMove(g);
end
