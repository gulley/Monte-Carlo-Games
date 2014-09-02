%% Tic Tac Toe Demo
% You can play a game manually like this.

%% Initialize
g = TicTacToe;
g.showResult

%% X Move 1
side = 1;
pos = 5;
iMove(g,pos,side);

%% O Move 1
pos = 1;
side = 2;
iMove(g,pos,side);

%% X Move 2
pos = 2;
side = 1;
iMove(g,pos,side);

%% O Move 2
pos = 7;
side = 2;
iMove(g,pos,side);

%% X Move 3
pos = 8;
side = 1;
iMove(g,pos,side);
