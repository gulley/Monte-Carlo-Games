%% Connect Four Demo
% Initialize

gameType = 2;
switch gameType
    case 1
        g = ConnectFour;
    case 2
        g = ConnectEl;
    case 3
        g = ConnectTee;
    case 4
        g = FourCorners;
end
g.showResult

%%
% Use this code to play against the robot. 
% Update your move and evaluate this section of code until one side wins.

mySide = 1;
myMove = 6;
iMove(g,myMove,mySide);
drawnow 

if ~g.isGameOver
    botMoves(g,200);
end

