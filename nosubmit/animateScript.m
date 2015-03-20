% Initialize
g = ConnectEl;
g.showBoard

gifFilename = 'connectel.gif';
animator(gifFilename,'first');
figwhite

% Two robots play until the game is over
nGames1 = 200;
nGames2 = 200;

while ~g.isGameOver
    botMoves(g,nGames1);
    animator(gifFilename,'add');
    
    if ~g.isGameOver
        botMoves(g,nGames2);
    end
    animator(gifFilename,'add');
    
end

