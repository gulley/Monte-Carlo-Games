%% Connect Four Demo
% Initialize

g = TicTacToe;
g.showBoard

%%
% Use this code to play against the robot. 
% Update your move and evaluate this section of code until one side wins.

mySide = 1;
myMove = 1;
iMove(g,myMove,mySide);
drawnow 

if ~g.isGameOver
    botMoves(g,1000);
end

