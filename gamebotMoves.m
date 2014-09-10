function gamebotMoves(game,nGames)
    % game is a class
    % nGames refers to how many Monte Carlo simulations you want to run for
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
        % More than one move is possible. Which is the best one?
        move = pickBestMove(game,moves,side,nGames);
        
    end
    
    % fprintf('Side %d: %d\n',side,move);
    game.makeMove(move,side);
    game.showResult
    
end

function pos = pickBestMove(game,potentialMoveList,mySide,nGames)
    
    nPotentialMoves = length(potentialMoveList);
    outcomelist = zeros(nPotentialMoves,3);
    
    % outcomelist has three columns and as many rows as there are potential
    % moves
    %   column 1 is the number of times Side 1 wins
    %   column 2 is the number of times Side 2 wins
    %   column 3 is the number of ties
    % Each row should sum to nGames
    
    % Iterate across all potential moves
    % At each point, measure how many wins and losses we can expect
    
    otherSide = toggleSide(mySide);
    
    for i = 1:nPotentialMoves
        
        verbose = false;
        if verbose
            fprintf('%04.1f %%\n',100*i/nPotentialMoves);
        end
        
        % Victory Short-Circuit
        % Imagine we make move i
        % See a victory one move ahead? Take it now!
        newGame = game.copy;
        newGame.makeMove(potentialMoveList(i),mySide);
        winner = newGame.isGameOver;
        if winner==mySide
            pos = potentialMoveList(i);
            return
        end
        
        % Defeat Short-Circuit
        % Imagine opponent makes move i
        % See a defeat one move ahead? Block it now!
        newGame = game.copy;
        newGame.makeMove(potentialMoveList(i),otherSide);
        winner = newGame.isGameOver;
        if winner==otherSide
            pos = potentialMoveList(i);
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
    pos = potentialMoveList(ix(mySide));
    
end

function rTotals = playManyGames(game,nGames)
    % From boardstate b0, play random games and report the results.
    % This code should be agnostic to the rules of the game
    % Input b0: the starting board
    % Input side: who has the next move
    % Input nGames: how many games to play
    % Output r is a 1x3 vector: [1 wins, 2 wins, draw]
    
    rTotals = [0 0 0];
    
    % Try a parfor here
    for i = 1:nGames
        newGame = game.copy;
        gameOver = false;
        while ~gameOver
            
            newGame.makeMove(randomMove(newGame),newGame.whoseMove);
            winner = newGame.isGameOver;
            if winner
                rTotals(winner) = rTotals(winner) + 1;
                gameOver = true;
            end
            
        end % while
        
    end % for
    
end % function

function move = randomMove(game)
    
    % Pick exactly one of the legal moves
    moves = game.possibleMoves;
    move = moves(ceil(rand*length(moves)));
    
end

function sideOut = toggleSide(sideIn)
    
    sideOut = 3 - sideIn;
    
end