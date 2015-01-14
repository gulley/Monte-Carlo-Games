%% Hex Demo
% You play robot against robot like this.

%% Initialize
game = Hex;
game.showBoard

%
% Use this code to watch the robot play against itself.

% Repeat this command until one side wins or there's a tie.
while ~game.isGameOver
    botMoves(game,20)
    drawnow
end

