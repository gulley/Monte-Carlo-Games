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
            
            g.boardstate(pos) = side;
            g.displayBoard;

        end
        
        % =================================================================
        function g = autoMove(g, side)
            if nargin < 2
                side = 2;
            end
            
            % Find all the legal moves
            board0 = g.boardstate;
            boardmask = possibleMove(board0);
            poslist = find(boardmask);
            outcomelist = zeros(length(poslist),3);
            ngames = 100;
            
            % Iterate across all legal moves
            % At each point, measure how many wins and losses we can expect
            
            for i = 1:length(poslist)
                board = move(board0,poslist(i),side);
                side = toggleSides;
                [xwin,owin,tie] = playManyGames(board,side);
                outcomelist(i,:) = [xwin,owin,tie];
            end
         
            % Pick the most favorable outcome
            
        end
        
        % =================================================================
        % INTERNAL
        % =================================================================
        
                
        % =================================================================
        function boardmask = possibleMoves(board)
            % Where are the legal moves?
            
            boardmask = (board==0);

        end
        
        % =================================================================
        function boardOut = move(boardIn,pos,side)
            
            boardOut = boardIn;
            boardOut(pos) = side;

        end
        
        % =================================================================
        function sideOut = toggleSides(sideIn)
            % Generic
            % Switch from side 1 to side 2 and vice versa
            
            sideOut = 3 - sideIn;

        end
        
        
        %         % =================================================================
        %         function g = computerMove(g)
        %             % What are all the legal moves?
        %             b0 = g.board;
        %             ix = find(b0==0);
        %             xWins = zeros(size(b0));
        %             oWins = zeros(size(b0));
        %             tie = zeros(size(b0));
        %
        %             % Computer plays O
        %             side = 2;
        %
        %             for i = 1:length(ix)
        %                 b = b0;
        %                 b(ix(i)) = side;
        %                 rTotals = fooey;
        %                 %                 rTotals = [1 2 3];
        %                 xWins(ix(i)) = rTotals(1);
        %                 oWins(ix(i)) = rTotals(2);
        %                 tie(ix(i)) = rTotals(3);
        %             end
        %
        %             xWins
        %             oWins
        %             tie
        %
        %         end
        %
        %         % =================================================================
        %         function m = randomMove(b)
        %             mlist = b==0;
        %             % Pick exactly one of the legal moves
        %             ix = find(mlist);
        %             if isempty(ix)
        %                 m = [];
        %                 disp('No legal moves')
        %                 return
        %             end
        %             ix = ix(ceil(rand*length(ix)));
        %             m = false(size(m));
        %             m(ix) = true;
        %         end
        %
        %         % =================================================================
        %         function b = makeMove(b,m,side)
        %             b(m) = side;
        %         end
        %
        %         % =================================================================
        %         function r = isGameOver(b)
        %
        %             ix = [ ...
        %                 1 4 7 1 2 3 1 3
        %                 2 5 8 4 5 6 5 5
        %                 3 6 9 7 8 9 9 7];
        %
        %             s = b(ix);
        %
        %             if any(prod(s==1))
        %                 r = 1;
        %             elseif any(prod(s==2))
        %                 r = 2;
        %             elseif ~any(b(:)==0)
        %                 r = 3;
        %             else
        %                 r = 0;
        %             end
        %
        %         end
        %
        %         % =================================================================
        %         function rTotals = monteCarlo2(b0,side)
        %             % From game position b0, play random games and report the
        %             % results.
        %             % This code should be agnostic to the rules of the game
        %             % Input b0: the starting board
        %             % Input side: who has the next move
        %             % Input nGames: how many games to play
        %             % Output r is a 1x3 vector: [1 wins, 2 wins, draw]
        %
        %             %             if nargin<3
        %             nGames = 100;
        %             %             end
        %
        %             rTotals = [0 0 0];
        %
        %             for i = 1:nGames
        %                 b = b0;
        %                 gameOver = false;
        %                 while ~gameOver
        %                     b = makeMove(b,randomMove(b),side);
        %                     r = isGameOver(b);
        %                     if r
        %                         rTotals(r) = rTotals(r) + 1;
        %                         gameOver = true;
        %                     end
        %                     % Next move is take by the other side
        %                     side = 3 - side;
        %
        %                 end % while
        %
        %             end % for
        %
        %         end % function
        %
        %
        %         % =================================================================
        
        
    end % methods
    
end % classdef