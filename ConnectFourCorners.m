classdef ConnectFourCorners < handle
    % Connect Four Corners
    % The Connect Four board is managed as a 1x42 vector
    
    % boardstate:  1x42 vector with 0=empty, 1=red, 2=black
    % boardmask:   1x7 vector with logical to indicate open moves
    % poslist:     column vector of board positions (1-7 index into board)
    % pos:         a single position from the poslist
    % outcomelist: associates wins and ties with each possible move
    
    properties
        boardstate
    end
    
    methods
        
        function g = ConnectFourCorners(initialBoardstate)
            % Constructor
            if nargin < 1
                initialBoardstate = zeros(1,42);
            end
            g.boardstate = initialBoardstate;
        end
        
        function newGame = copy(game)
            newGame = ConnectFourCorners(game.boardstate);
        end
        
        function showResult(game)
            game.showBoard;
            r = game.isGameOver;
            if r==1
                fprintf('Red wins.\n')
            elseif r==2
                fprintf('Black wins.\n')
            elseif r==3
                fprintf('Tie game.\n')
            end
        end
        
        function makeMove(game, pos, side)
            if nargin < 3
                side = 1;
            end
            
            % The piece is dropped into the Connect Four grid and falls to
            % the bottom.
            
            b = reshape(game.boardstate,6,7);
            
            if prod(b(:,pos))
                fprintf('That column is full. You can''t move there.')
                game.showBoard;
                return
            end
            
            emptySlots = find(b(:,pos)==0);
            b(emptySlots(end),pos) = side;
            game.boardstate = b(:);
            
        end
        
        function moves = possibleMoves(game)
            % Where are the legal moves?
            
            b = reshape(game.boardstate,6,7);
            % Any column that still has empty space in it represents a
            % legal move.
            moves = find(prod(b)==0);
        end
        
        function r = isGameOver(game)
            b = reshape(game.boardstate,6,7);
            
            % Code courtesy of Alfonso Nieto-Castanon
            % See http://www.mathworks.com/matlabcentral/cody/problems/512-spot-the-rectangle/solutions/63821
            r = 0;
            
            b1 = double(b==1);
            tr1 = triu( (b1' * b1)>1, 1);
            if any(tr1(:))
                r = 2;
                return
            end
            
            b2 = double(b==2);
            tr2 = triu( (b2' * b2)>1, 1);
            if any(tr2(:))
                r = 1;
                return
            end
            
            if all(b(:))
                r = 3;
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
        
        function showBoard(g,style)
            % Display method
            board = reshape(g.boardstate,6,7);
            drawConnectFourBoard(board)
        end
        
    end
    
end % classdef