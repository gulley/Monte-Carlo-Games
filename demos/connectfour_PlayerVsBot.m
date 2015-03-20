%% Connect Four Demo
% Initialize

gameType = 2;
switch gameType
    case 1
        game = ConnectFour;
    case 2
        game = ConnectEl;
    case 3
        game = ConnectTee;
    case 4
        game = FourCorners;
end
game.showResult

%%
% Use this code to play against the robot. 
% Update your move and evaluate this section of code until one side wins.

mySide = 1;
myMove = 6;
iMove(game,myMove,mySide);
drawnow 

if ~game.isGameOver
    botMoves(game,200);
end

