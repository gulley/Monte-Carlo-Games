%% Tic Tac Toe Demo
% You can play a game manually like this.

%% Initialize
g = TicTacToe
g.showResult

%% X Move 1
side = 1;
pos = 5;
makeMove(g,pos,side);
g.showResult

%% O Move 1
pos = 1;
side = 2;
makeMove(g,pos,side);
g.showResult

%% X Move 2
pos = 2;
side = 1;
makeMove(g,pos,side);
g.showResult

%% O Move 2
pos = 7;
side = 2;
makeMove(g,pos,side);
g.showResult

%% X Move 3
pos = 8;
side = 1;
makeMove(g,pos,side);
g.showResult
