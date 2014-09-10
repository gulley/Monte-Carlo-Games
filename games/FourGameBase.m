classdef FourGameBase < handle
    % Four Game Base
    % This is the base class for a variety of games played on a 6x7 grid
    % with red and black pieces. The subclassed games all differ slightly
    % in their victory conditions.
    
    properties
        boardstate
        % boardhistory
    end
    
    methods
        
        function g = FourGameBase(initialBoardstate)
            % Constructor
            if nargin < 1
                initialBoardstate = zeros(6,7);
            end
            g.boardstate = initialBoardstate;
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

            b = game.boardstate;
            
            if prod(b(:,pos))
                fprintf('That column is full. You can''t move there.')
                game.showBoard;
                return
            end
            
            emptySlots = find(b(:,pos)==0);
            b(emptySlots(end),pos) = side;
           
            game.boardstate = b;
           
        end
        
        function moves = possibleMoves(game)
            % Where are the legal moves?
            
            b = game.boardstate;
            
            % Any column that still has empty space in it represents a
            % legal move.
            moves = find(prod(b)==0);
        end
               
        function side = whoseMove(game)
            % If there are an even number of pieces on the board, side 1
            % moves next
            side = rem(nnz(game.boardstate),2) + 1;
        end
        
        function showBoard(game,style)
            % Display method
            board = game.boardstate;
            game.drawConnectFourBoard
        end
        
        function drawConnectFourBoard(game,style)
            board = game.boardstate;
            % Display method
            if nargin < 2
                % style='text';
                style='graphical';
            end
            
            if strcmp(style,'text')
                game.showBoardText
            elseif strcmp(style,'graphical')
                game.showBoardGraphical
            end
            
        end
        
        function showBoardText(game)
            board = game.boardstate;
            fprintf('\n');
            for r=1:6
                
                for c=1:7
                    switch board(r,c)
                        case 1
                            str = 'R';
                        case 2
                            str = 'B';
                        otherwise
                            str = '.';
                    end
                    
                    fprintf('%s',str);
                    
                end
                fprintf('\n');
            end
            fprintf('\n');
        end % function display
        
        function showBoardGraphical(game)
            board = game.boardstate;
            
            clf
            for r=1:6
                for c=1:7
                    switch board(r,c)
                        case 1
                            markerStr = '.';
                            colorStr = 'red';
                        case 2
                            markerStr = '.';
                            colorStr = 'black';
                        otherwise
                            markerStr = 'none';
                            colorStr = 'white';
                            if r==6
                                text(c-0.5,r-0.5,num2str(c))
                            elseif board(r+1,c)
                                text(c-0.5,r-0.5,num2str(c))
                            end
                    end
                    line(c-0.5,r-0.5,'Marker',markerStr,'MarkerSize',90,'MarkerEdgeColor',colorStr);
                    
                end
            end
            axis ij
            axis([0 7 0 6])
            set(gca,'XTick',0:7,'YTick',0:6)
            set(gca,'XTickLabel',[],'YTickLabel',[])
            grid on
            box on
            drawnow
            
        end
        
    end
    
end % classdef