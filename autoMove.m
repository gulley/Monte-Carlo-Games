function autoMove(game)
    
    % Find all the legal moves
    side = game.whoseMove;
    moves = game.possibleMoves;
        
    if isempty(moves)
        % No moves are possible.
        fprintf('No moves remain. Game is over.\n')
        return
        
    elseif length(moves)==1
        % One move is possible. Make it.
        move = moves;
        
    else
        move = pickBestMove(game,moves,side);
        
    end
    game.makeMove(move,side);
    
end

function pos = pickBestMove(game,poslist,side)
    
    outcomelist = zeros(length(poslist),3);
    ngames = 100;
    
    % Iterate across all legal moves
    % At each point, measure how many wins and losses we can expect
    
    for i = 1:length(poslist)
        newGame = game.copy; % imagine we make move i
        newGame.makeMove(poslist(i),side);
        r = playManyGames(newGame,ngames);
        outcomelist(i,:) = r;
    end
    
    % Column 3 is the ties
    % We want to maximize the chance of winning or tying (i.e.
    % minimize the chance of losing).
    outcomelist(:,1) = outcomelist(:,1) + outcomelist(:,3);
    outcomelist(:,2) = outcomelist(:,2) + outcomelist(:,3);
    [~,ix] = max(outcomelist);
    
    % Pick the most favorable outcome
    pos = poslist(ix(side));
end

function rTotals = playManyGames(game,nGames)
    % From boardstate b0, play random games and report the results.
    % This code should be agnostic to the rules of the game
    % Input b0: the starting board
    % Input side: who has the next move
    % Input nGames: how many games to play
    % Output r is a 1x3 vector: [1 wins, 2 wins, draw]
    
    if nargin<2
        nGames = 100;
    end
    
    rTotals = [0 0 0];
    
    for i = 1:nGames
        newGame = game.copy;
        gameOver = false;
        while ~gameOver
            
            newGame.makeMove(randomMove(newGame),newGame.whoseMove);
            r = newGame.isGameOver;
            if r
                rTotals(r) = rTotals(r) + 1;
                gameOver = true;
            end
            
        end % while
        
    end % for
    
end % function

function move = randomMove(game)
    
    moves = game.possibleMoves;
    
    % Pick exactly one of the legal moves
    move = moves(randi(length(moves),1,1));
    
end

