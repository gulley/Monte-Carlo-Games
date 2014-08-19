%% Tic Tac Toe Demo
% You can play a game manually like this.

%% Initialize
g = game
g.displayBoard

%% X Move 1
clc
side = 1;
pos = 5;
g = makeMove(g,pos,side);

%% O Move 1
pos = 1;
side = game.toggleSides(side);
g = makeMove(g,pos,side);

%% X Move 2
pos = 2;
side = game.toggleSides(side);
g = makeMove(g,pos,side);

%% O Move 2
pos = 7;
side = game.toggleSides(side);
g = makeMove(g,pos,side);

%% X Move 3
pos = 8;
side = game.toggleSides(side);
g = makeMove(g,pos,side);
