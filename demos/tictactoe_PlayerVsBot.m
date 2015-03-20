%% Connect Four Demo
% Initialize

game = TicTacToe;
game.showBoard

%%
% Use this code to play against the robot. 
% Update your move and evaluate this section of code until one side wins.

mySide = 1;
myMove = 8;
iMove(game,myMove,mySide);
drawnow 

if ~game.isGameOver
    botMoves(game,10);
end

