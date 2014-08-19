classdef game
    
    properties
        boardstate
    end
    
    methods
        % Tic Tac Toe
        % The Tic Tac Toe board is managed as a 1x9 vector
        
        % boardstate:  1x9 vector with 0=empty, 1=X, 2=O
        % boardmask:   1x9 vector with logical to indicate open moves
        % poslist:     column vector of board positions (1-9 index into board)
        % pos:         a single position from the poslist
        % outcomelist: associates wins and ties with each possible move
        
        % =================================================================
        function g = game(initialBoardstate)
            % Constructor
            if nargin < 1
                initialBoardstate = zeros(1,9);
            end
            g.boardstate = initialBoardstate;
        end
        
        % =================================================================
        function displayBoard(g)
            % Display method
            
            b = reshape(g.boardstate,3,3);
            
            fprintf('\n');
            for r=1:3
                
                if r>1
                    fprintf('-----------\n');
                end
                
                for c=1:3
                    switch b(r,c)
                        case 1
                            str = 'X';
                        case 2
                            str = 'O';
                        otherwise
                            n = sub2ind([3, 3],r,c);
                            str = num2str(n);
                    end
                    
                    if c>1
                        fprintf('|');
                    end
                    fprintf(' %s ',str);
                    
                end
                fprintf('\n');
            end
            fprintf('\n');
        end % function display
        
        % =================================================================
        function g = makeMove(g, pos, side)
            if nargin < 3
                side = 1;
            end
            
            if ~g.boardstate(pos)
                g.boardstate(pos) = side;
            else
                fprintf('That position is occupied. You can''t move there.')
                g.displayBoard;
                return
            end
            g.displayBoard;
            r = game.isGameOver(g.boardstate);
            if r==1
                fprintf('X wins.\n')
            elseif r==2
                fprintf('O wins.\n')
            elseif r==3
                fprintf('Tie game.\n')
            end
            
        end
        
        % =================================================================
        function g = autoMove(g)
            
            % Find all the legal moves
            board0 = g.boardstate;
            side = game.whoseMove(board0);
            boardmask = game.possibleMoves(board0);
            poslist = find(boardmask);
            outcomelist = zeros(length(poslist),3);
            ngames = 100;
            
            % Iterate across all legal moves
            % At each point, measure how many wins and losses we can expect
            
            for i = 1:length(poslist)
                boardstate = game.move(board0,poslist(i),side);
                r = game.playManyGames(boardstate);
                outcomelist(i,:) = r;
            end
            
            % Column 3 is the ties
            % We want to maximize the chance of winning or tying (i.e.
            % minimize the chance of losing).
            outcomelist(:,1) = outcomelist(:,1) + outcomelist(:,3);
            outcomelist(:,2) = outcomelist(:,2) + outcomelist(:,3);
            [mx,ix] = max(outcomelist);
            
            % Pick the most favorable outcome
            pos = poslist(ix(side));
            g = makeMove(g,pos,side);
            
        end
        
    end % methods
    
    % =================================================================
    % STATIC METHODS
    % =================================================================
    
    methods (Static)
        
        % =================================================================
        function boardmask = possibleMoves(boardstate)
            % Where are the legal moves?
            
            boardmask = (boardstate==0);
            
        end
        
        % =================================================================
        function sideOut = toggleSides(sideIn)
            % Generic
            % Switch from side 1 to side 2 and vice versa
            
            sideOut = 3 - sideIn;
            
        end
        
        % =================================================================
        function r = isGameOver(boardstate)
            
            ix = [ ...
                1 4 7 1 2 3 1 3
                2 5 8 4 5 6 5 5
                3 6 9 7 8 9 9 7];
            
            s = boardstate(ix);
            
            if any(prod(s==1))
                r = 1;
            elseif any(prod(s==2))
                r = 2;
            elseif ~any(boardstate(:)==0)
                r = 3;
            else
                r = 0;
            end
            
        end
        
        % =================================================================
        function side = whoseMove(b)
            % If there are the same number of Xs and Os, then X goes next.
            if sum(b(:)==1) == sum(b(:)==2)
                side = 1;
            else 
                side = 2;
            end
        end
        
        % =================================================================
        function pos = randomMove(boardstate)
            
            boardmask = game.possibleMoves(boardstate);
            poslist = find(boardmask);
            
            % Pick exactly one of the legal moves
            pos = poslist(randi(length(poslist),1,1));

        end
        
        % =================================================================
        function boardstateOut = move(boardstateIn,pos,side)
            boardstateOut = boardstateIn;
            boardstateOut(pos) = side;
        end
        
        
        % =================================================================
        function rTotals = playManyGames(b0,nGames)
            % From boardstate b0, play random games and report the results.
            % This code should be agnostic to the rules of the game
            % Input b0: the starting board
            % Input side: who has the next move
            % Input nGames: how many games to play
            % Output r is a 1x3 vector: [1 wins, 2 wins, draw]
            
            if nargin<2
                nGames = 100;
            end
            
            side = game.whoseMove(b0);
            
            rTotals = [0 0 0];
            
            for i = 1:nGames
                boardstate = b0;
                gameOver = false;
                
                while ~gameOver
                    
                    boardstate = game.move(boardstate,game.randomMove(boardstate),game.whoseMove(boardstate));
                    r = game.isGameOver(boardstate);
                    if r
                        rTotals(r) = rTotals(r) + 1;
                        gameOver = true;
                    end
                    
                end % while
                
            end % for
            
        end % function
        
        % =================================================================
        
        
    end % static methods
    
end % classdef