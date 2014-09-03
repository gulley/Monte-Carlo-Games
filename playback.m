bh = g.boardhistory;

% max(bh(:))
n = 7;
bh(bh>n) = 0;
b = bh;
b(rem(b,2)==1) = 1;
b((rem(b,2)==0)&(bh>0)) = 2;

g2 = ConnectEl(b);
g2.showBoard

%%

gamebotMoves(g2,10)

