classdef TicTacToe < handle
    
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
        function g = TicTacToe(initialBoardstate)
            % Constructor
            if nargin < 1
                initialBoardstate = zeros(1,9);
            end
            g.boardstate = initialBoardstate;
        end
        
        function newGame = copy(game)
            newGame = TicTacToe(game.boardstate);
        end
        
        % =================================================================
        function showBoard(g)
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
                            % n = sub2ind([3, 3],r,c);
                            % str = num2str(n);
                            str = ' ';
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
        
        function showResult(game)
            game.showBoard;
            r = game.isGameOver;
            if r==1
                fprintf('X wins.\n')
            elseif r==2
                fprintf('O wins.\n')
            elseif r==3
                fprintf('Tie game.\n')
            end
        end
                
        function makeMove(game, pos, side)
            if nargin < 3
                side = 1;
            end
            
            if ~game.boardstate(pos)
                game.boardstate(pos) = side;
            else
                fprintf('That position is occupied. You can''t move there.')
                game.showBoard;
                return
            end
        end
        
        function moves = possibleMoves(game)
            % Where are the legal moves?            
            moves = find(game.boardstate==0);            
        end
        
        function r = isGameOver(game)
            
            ix = [ ...
                1 4 7 1 2 3 1 3
                2 5 8 4 5 6 5 5
                3 6 9 7 8 9 9 7];
            
            s = game.boardstate(ix);
            
            if any(prod(s==1))
                r = 1;
            elseif any(prod(s==2))
                r = 2;
            elseif ~any(game.boardstate(:)==0)
                r = 3;
            else
                r = 0;
            end
            
        end
        
        function side = whoseMove(game)
            % If there are the same number of Xs and Os, then X goes next.
            if sum(game.boardstate(:)==1) == sum(game.boardstate(:)==2)
                side = 1;
            else
                side = 2;
            end
        end
        
    end
    
end % classdef