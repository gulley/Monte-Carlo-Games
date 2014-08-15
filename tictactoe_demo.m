%% Tic Tac Toe Demo
% I can play a game manually like this.

%% Initialize
g = game
g.displayBoard

%% X Move 1
clc
g = makeMove(g,5);

%% O Move 1
g = makeMove(g,1,2);

%% X Move 2
g = makeMove(g,2);

%% O Move 2
g = makeMove(g,7,2);

%% X Move 3
g = makeMove(g,8);
