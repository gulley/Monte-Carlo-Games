classdef TicTacToe < handle
    % Tic Tac Toe
    % The board is managed as a 3x3 matrix
    
    properties
        board
    end
    
    methods
        
        function g = TicTacToe(initialBoard)
            % Constructor
            if nargin < 1
                initialBoard = zeros(3,3);
            end
            g.board = initialBoard;
        end
        
        function newGame = copy(game)
            newGame = TicTacToe(game.board);
        end
        
        function side = whoseMove(game)
            % If there are an even number of pieces, X goes next
            if rem(nnz(game.board),2)==0
                side = 1;
            else
                side = 2;
            end
        end
        
        function moves = possibleMoves(game)
            % Where are the legal moves?
            moves = find(game.board==0);
        end
        
        function makeMove(game, pos, side)
            % Update the board to reflect the indicated move
            
            if ~game.board(pos)
                game.board(pos) = side;
            else
                fprintf('That position is occupied. You can''t move there.')
                game.showBoard;
            end
        end
        
        function result = isGameOver(game)
            % result = 0 => Game is not over.
            % result = 1 => Side 1 wins.
            % result = 2 => Side 2 wins.
            % result = 3 => Board is full. Game is a draw.
            
            ix = [ ...
                1 4 7 1 2 3 1 3
                2 5 8 4 5 6 5 5
                3 6 9 7 8 9 9 7];
            
            s = game.board(ix);
            
            if any(prod(s==1))
                result = 1;
            elseif any(prod(s==2))
                result = 2;
            elseif ~any(game.board(:)==0)
                result = 3;
            else
                result = 0;
            end
            
        end
        
        function showBoard(game)
            
            possibleMoves = game.possibleMoves;           
            b = game.board;
            
            % In each box...
            % hm - a marker to be used for a game piece
            % ht - text used for position index
            
            hMarker = zeros(size(b));
            hText = zeros(size(b));
            
            clf
            for r=1:size(b,1)
                for c=1:size(b,2)
                    hMarker(r,c) = line(c-0.5,r-0.5, ...
                        'LineStyle','none','LineWidth',3, ...
                        'MarkerEdgeColor','none', ...
                        'MarkerFaceColor','none', ...
                        'MarkerSize',50);
                    hText(r,c) = text(c-0.2,r-0.2,'', ...
                        'Color',0.5*[1 1 1], ...
                        'HorizontalAlignment','center');
                end
            end
            
            for i = 1:length(possibleMoves)
                num = possibleMoves(i);
                numStr = sprintf('%d',num);
                set(hText(possibleMoves(i)),'String',numStr)
            end
            
            markerStr = 'x';
            edgecolor = [0 0 0];
            set(hMarker(b==1), ...
                'Marker',markerStr, ...
                'MarkerEdgeColor',edgecolor, ...
                'LineWidth',3);
            
            markerStr = 'o';
            edgecolor = [0 0 1];
            set(hMarker(b==2), ...
                'Marker',markerStr, ...
                'MarkerEdgeColor',edgecolor, ...
                'LineWidth',3);
                        
            axis ij
            axis([0 3 0 3])
            axis square
            set(gca,'XTick',0:3,'YTick',0:3)
            set(gca,'XTickLabel',[],'YTickLabel',[])
            grid on
            box on
            drawnow
            
            result = game.isGameOver;
            if result==1
                title('X wins')
            elseif result==2
                title('O wins')
            elseif result==3
                title('Tie game')
            end

        end
        
    end
    
end 