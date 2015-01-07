function gamebotMoves(game,nGames)
    % game:   a class
    % nGames: number of random simulated game to run for each potential move.
    
    % Find all the legal moves
    moves = game.possibleMoves;
    side = game.whoseMove;
    winnerCounts = [];
    
    if isempty(moves)
        % No moves are possible.
        fprintf('No moves remain. Game is over.\n')
        return
        
    elseif length(moves)==1
        % One move is possible. Make it.
        move = moves;
        
    else
        % More than one move is possible. Which is the best one?
        winnerCounts = ratePossibleMoves(game,moves,side,nGames);
        
        % Maximize likelihood of victory
        %         winnerCounts = winnerCounts(:,side) + winnerCounts(:,3);
        winnerCounts = winnerCounts(:,side);
        [~,ix] = max(winnerCounts);
        
        move = moves(ix);
        
    end
    
    game.makeMove(move,side);
    winnerCounts = [];
    game.showBoard(moves,winnerCounts)
    %     game.showBoard(moves)
    
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