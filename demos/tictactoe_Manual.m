%% Tic Tac Toe Demo
% You can play a game manually. In this game, I make all the moves for both
% sides. Not very interesting.

%% Initialize
g = TicTacToe;
g.showBoard

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
