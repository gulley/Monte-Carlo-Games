classdef FourGameBase < handle
    % Four Game Base
    % This is the base class for a variety of games played on a 6x7 grid
    % with red and black pieces. The subclassed games all differ slightly
    % in their victory conditions.
    
    properties
        board
        % boardhistory
    end
    
    methods
        
        function g = FourGameBase(initialBoardstate)
            % Constructor
            if nargin < 1
                initialBoardstate = zeros(6,7);
            end
            g.board = initialBoardstate;
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
            % The piece is dropped into the Connect Four grid and falls to
            % the bottom.
            
            b = game.board;
            
            if prod(b(:,pos))
                fprintf('That column is full. You can''t move there.')
                game.showBoard;
                return
            end
            
            emptySlots = find(b(:,pos)==0);
            b(emptySlots(end),pos) = side;
            
            game.board = b;
            
        end
        
        function moves = possibleMoves(game)
            % Where are the legal moves?
            
            b = game.board;
            
            % Any column that still has empty space in it represents a
            % legal move.
            moves = find(prod(b)==0);
        end
        
        function side = whoseMove(game)
            % If there are an even number of pieces on the board, side 1
            % moves next
            side = rem(nnz(game.board),2) + 1;
        end
        
        function showBoard(game, possibleMoves, winnerCounts)
            
            if nargin < 2
                possibleMoves = game.possibleMoves;
                winnerCounts = [];
            end
            
            vMax = max(winnerCounts);
            vMin = min(winnerCounts);
            b = game.board;
            [nRows,nCols] = size(b);
            
            % In each box...
            % hMarker - a marker to be used for a game piece
            % hText - text used for position index or rating
            
            hMarker = zeros(nRows,nCols);
            hText = zeros(nRows,nCols);
            
            clf
            for r=1:nRows
                for c=1:nCols
                    hMarker(r,c) = line(c-0.5,r-0.5, ...
                        'LineStyle','none','LineWidth',3, ...
                        'MarkerEdgeColor','none', ...
                        'MarkerFaceColor','none', ...
                        'MarkerSize',90);
                    hText(r,c) = text(c-0.5,r-0.5,'', ...
                        'HorizontalAlignment','center');
                end
            end
            
            for i = 1:length(possibleMoves)
                c = possibleMoves(i);
                r = find(b(:,c)==0,1,'last');
                if isempty(winnerCounts)
                    num = possibleMoves(i);
                    numStr = sprintf('%d',num);
                    set(hText(r,c),'String',numStr)
                else
                    num = winnerCounts(i);
                    numStr = sprintf('%d',num);
                    
                    set(hText(r,c),'String',numStr)
                    if vMax > vMin
                        interpVal = interp1([vMin vMax],[0 0.5],num);
                        bgColor = 1-[0 interpVal interpVal];
                        set(hText(r,c), ...
                            'BackgroundColor', bgColor)
                    end
                end
            end
            
            markerStr = '.';
            edgecolor = [1 0 0];
            set(hMarker(b==1), ...
                'Marker',markerStr, ...
                'MarkerEdgeColor',edgecolor, ...
                'LineWidth',3);
            
            markerStr = '.';
            edgecolor = [0 0 0];
            set(hMarker(b==2), ...
                'Marker',markerStr, ...
                'MarkerEdgeColor',edgecolor, ...
                'LineWidth',3);
            
            axis ij
            axis([0 nCols 0 nRows])
            set(gca,'XTick',0:nCols,'YTick',0:nRows)
            set(gca,'XTickLabel',[],'YTickLabel',[])
            grid on
            box on
            drawnow
            
            result = game.isGameOver;
            if result==1
                title('Red wins')
            elseif result==2
                title('Black wins')
            elseif result==3
                title('Tie game')
            end
            
        end
        
    end
    
end % classdef