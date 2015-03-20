classdef Oxo < handle
    % OXO
    % The board is managed as a 8x8 matrix
    
    properties
        board
    end
    
    methods
        
        function g = Oxo(initialBoard)
            % Constructor
            if nargin < 1
                len = 6;
                initialBoard = zeros(len);
            end
            g.board = initialBoard;
        end
        
        function newGame = copy(game)
            newGame = Oxo(game.board);
        end
        
        function side = whoseMove(game)
            % If there are an even number of pieces, "O" goes next
            if rem(nnz(game.board),2)==0
                side = 2;
            else
                side = 1;
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
            
            result = 0;
            b = game.board;
            
            directions = { ...
                [5;13;5], ...
                [5,13,5]};
            
            for direction = directions
                if any(any( conv2(b,direction{1},'same') == 33 ))
                    % If the pattern "OXO" appears, then whoever JUST MOVED
                    % wins the game.
                    result = 3-game.whoseMove;
                    return
                end
            end
            
            if ~any(game.board(:)==0)
                result = 3;
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
            
            len = size(b,1);
            
            clf
            title(' ')
            for r=1:len
                for c=1:len
                    hMarker(r,c) = line(c-0.5,r-0.5, ...
                        'LineStyle','none','LineWidth',3, ...
                        'MarkerEdgeColor','none', ...
                        'MarkerFaceColor','none', ...
                        'MarkerSize',20);
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
            axis([0 len 0 len])
            axis square
            set(gca,'XTick',0:len,'YTick',0:len)
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