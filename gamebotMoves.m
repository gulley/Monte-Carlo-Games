function gamebotMoves(game,ngames)
    % ngames refers to how many Monte Carlo simulation you want to run for
    % each potential move.
    
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
        move = pickBestMove(game,moves,side,ngames);
        
    end
    game.makeMove(move,side);
    game.showResult
    
end

function pos = pickBestMove(game,potentialMoveList,side,nGames)
    
    nPotentialMoves = length(potentialMoveList);
    outcomelist = zeros(nPotentialMoves,3);
    % outcomelist has three columns and as many rows as there are potential
    % moves
    %   column 1 is the number of side 1 wins
    %   column 2 is the number of side 2 wins
    %   column 3 is the number of ties
    
    % Iterate across all potential moves
    % At each point, measure how many wins and losses we can expect
    
    otherSide = toggleSide(side);
    
    for i = 1:nPotentialMoves
        
        % Imagine we make move i
        % See a victory one move ahead? Take it now!
        % Short-circuit and return if you need to win.
        newGame = game.copy;
        newGame.makeMove(potentialMoveList(i),side);
        if newGame.isGameOver == side
            pos = potentialMoveList(i);
            return
        end
        
        % Imagine opponent makes move i
        % See a loss one move ahead? Avoid it now!
        % Short-circuit and return if you need to block a winning move.
        newGame = game.copy;
        newGame.makeMove(potentialMoveList(i),otherSide);
        if newGame.isGameOver == otherSide
            pos = potentialMoveList(i);
            return
        end
        
        % Imagine we make move i
        newGame = game.copy;
        newGame.makeMove(potentialMoveList(i),side);
        
        % See a victory one move ahead? Take it now!
        % Short-circuit and return if you need to block a winning move.
        if newGame.isGameOver == side
            pos = poslist(i);
            return
        end
        
        r = playManyGames(newGame,nGames);
        outcomelist(i,:) = r;
        
    end
    % We want to maximize the chance of winning or tying
    % (i.e. minimize the chance of losing).
    
    outcomelist(:,1) = outcomelist(:,1) + outcomelist(:,3);
    outcomelist(:,2) = outcomelist(:,2) + outcomelist(:,3);
    [~,ix] = max(outcomelist);
        
    % Pick the most favorable outcome
    pos = potentialMoveList(ix(side));
    
    
end

function rTotals = playManyGames(game,ngames)
    % From boardstate b0, play random games and report the results.
    % This code should be agnostic to the rules of the game
    % Input b0: the starting board
    % Input side: who has the next move
    % Input nGames: how many games to play
    % Output r is a 1x3 vector: [1 wins, 2 wins, draw]
    
    rTotals = [0 0 0];
    
    % Try a parfor here
    for i = 1:ngames
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

function sideOut = toggleSide(sideIn)
    sideOut = 3 - sideIn;
end