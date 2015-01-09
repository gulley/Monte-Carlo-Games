%% Tic Tac Toe Demo
% You can play a game manually. In this game, I make all the moves for both
% sides. Not very interesting.

%% Initialize
game = TicTacToe;
game.showBoard

%% X Move 1
side = 1;
pos = 5;
iMove(game,pos,side);

%% O Move 1
pos = 1;
side = 2;
iMove(game,pos,side);

%% X Move 2
pos = 2;
side = 1;
iMove(game,pos,side);

%% O Move 2
pos = 7;
side = 2;
iMove(game,pos,side);

%% X Move 3
pos = 8;
side = 1;
iMove(game,pos,side);
