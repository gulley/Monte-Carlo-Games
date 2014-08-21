%% Tic Tac Toe Demo
% You play robot against robot like this.

%% Initialize
g = TicTacToe
g.showBoard

%%
% Repeat this command until one side wins or there's a tie.
while ~g.isGameOver
    autoMove(g);
    g.showResult;
end
