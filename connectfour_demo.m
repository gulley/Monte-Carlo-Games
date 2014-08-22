%% Tic Tac Toe Demo
% You can play a game manually like this.

%% Initialize
g = ConnectFour;
g.showBoard;

%% X Move 1
side = 1;
pos = 4;
makeMove(g,pos,side);
g.showResult

%% O Move 1
side = 2;
pos = 3;
makeMove(g,pos,side);
g.showResult

%% X Move 2
side = 1;
pos = 4;
makeMove(g,pos,side);
g.showResult

%% O Move 2
side = 2;
pos = 2;
makeMove(g,pos,side);
g.showResult

%% X Move 3
side = 1;
pos = 4;
makeMove(g,pos,side);
g.showResult

%% O Move 3
side = 2;
pos = 1;
makeMove(g,pos,side);
g.showResult

%% X Move 4
side = 1;
pos = 4;
makeMove(g,pos,side);
g.showResult