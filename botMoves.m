function botMoves(game,nGames)
    % game:   a class
    % nGames: number of random simulated game to run for each potential move.
    
    % Find all the legal moves
    moves = game.possibleMoves;
    side = game.whoseMove;
    resultCounts = [];
    
    if isempty(moves)
        % No moves are possible.
        fprintf('No moves remain. Game is over.\n')
        return
        
    elseif length(moves)==1
        % One move is possible. Make it.
        move = moves;
        
    else
        % More than one move is possible. Which is the best one?
        resultCounts = ratePossibleMoves(game,moves,side,nGames);
        
        % Maximize likelihood of not losing (i.e. maximize victory + draw)
        resultCountsNoLose = resultCounts(:,side) + resultCounts(:,3);
        
        % Or maximize likelihood of victory only (ignore draws)
        resultCountsWinOnly = resultCounts(:,side);
        
        [~,ix] = max(resultCountsNoLose);
        
        move = moves(ix);
        
        showRatingsFlag = false;
        if showRatingsFlag
            showRatings(side, resultCounts, moves, ix)
        end
        
    end
    
    game.makeMove(move,side);
    game.showBoard

end

function winnerCounts = ratePossibleMoves(game,possibleMoveList,mySide,nGames)
    
    nPossibleMoves = length(possibleMoveList);
    winnerCounts = zeros(nPossibleMoves,3);
    
    otherSide = toggleSide(mySide);
    
    for i = 1:nPossibleMoves
        newGame = game.copy;
        newGame.makeMove(possibleMoveList(i),mySide);
        whoWins = playManyGames(newGame,nGames);
        winnerCounts(i,:) = whoWins;
    end
       
end

function whoWins = playManyGames(game,nGames)
    % From the current board, play many random games and report the results.
    % nGames: how many games to play
    % whoWins is a 1x3 vector: [wins for side 1, wins for side 2, draw]
    
    whoWins = [0 0 0];
    
    % Is the game is already over?
    winner = game.isGameOver;
    if winner
        whoWins(winner) = nGames;
        return
    end
    
    for i = 1:nGames
        randGame = game.copy;
        gameOver = false;
        while ~gameOver
            side = randGame.whoseMove;
            move = randomMove(randGame);
            randGame.makeMove(move,side);
            winner = randGame.isGameOver;
            % winner will be 0 (undetermined), 1, 2, or 3 (tie)
            if winner
                whoWins(winner) = whoWins(winner) + 1;
                gameOver = true;
            end
        end 
    end 
    
end 

function move = randomMove(game)
    % Pick exactly one of the legal moves
    moves = game.possibleMoves;
    move = moves(ceil(rand*length(moves)));    
end

function sideOut = toggleSide(sideIn)
    sideOut = 3 - sideIn;
end

function showRatings(side, resultCounts, moves, ix)
    
    fprintf('\nSIDE %d TO MOVE\n',side);
    if side==1
        fprintf('   Move    Wins    Loses    Ties\n')
    else
        fprintf('   Move   Loses     Wins    Ties\n')
    end
    fprintf('  ------  ------  ------  ------\n')
    for i = 1:length(moves)
        if i==ix
            str1 = ' >';
            str2 = '< ';
        else
            str1 = '  ';
            str2 = '  ';
        end
        fprintf('%s%5d.  %6d  %6d  %6d %s\n', ...
            str1, moves(i), ...
            resultCounts(i,1), resultCounts(i,2), resultCounts(i,3), ...
            str2)
    end
    fprintf('  ------  ------  ------  ------\n')
end
