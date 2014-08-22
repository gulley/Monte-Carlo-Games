classdef ConnectFour < handle
    % Connect Four
    % The Connect Four board is managed as a 1x42 vector
    
    % boardstate:  1x42 vector with 0=empty, 1=X, 2=O
    % boardmask:   1x7 vector with logical to indicate open moves
    % poslist:     column vector of board positions (1-7 index into board)
    % pos:         a single position from the poslist
    % outcomelist: associates wins and ties with each possible move
    
    properties
        boardstate
    end
    
    methods
        
        function g = ConnectFour(initialBoardstate)
            % Constructor
            if nargin < 1
                initialBoardstate = zeros(1,42);
            end
            g.boardstate = initialBoardstate;
        end
        
        function newGame = copy(game)
            newGame = ConnectFour(game.boardstate);
        end
        
        function showBoard(g,style)
            % Display method
            if nargin < 2
                % style='text';
                style='graphical';
            end
            
            if strcmp(style,'text')
                showBoardText(g)
            elseif strcmp(style,'graphical')
                showBoardGraphical(g)
            end
            
        end
        
        function showBoardText(g)
            
            b = reshape(g.boardstate,6,7);
            
            fprintf('\n');
            for r=1:6
                
                for c=1:7
                    switch b(r,c)
                        case 1
                            str = 'X';
                        case 2
                            str = 'O';
                        otherwise
                            str = '.';
                    end
                    
                    fprintf('%s',str);
                    
                end
                fprintf('\n');
            end
            fprintf('\n');
        end % function display
        
        function showBoardGraphical(g)
            
            b = reshape(g.boardstate,6,7);
            
            cla
            for r=1:6
                for c=1:7
                    switch b(r,c)
                        case 1
                            markerStr = '.';
                            colorStr = 'red';
                        case 2
                            markerStr = '.';
                            colorStr = 'black';
                        otherwise 
                            markerStr = 'none';
                            colorStr = 'white';
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
            
            % Code courtesy of @bmtran
            % See http://www.mathworks.com/matlabcentral/cody/problems/90-connect-four-win-checker/solutions/2314
            r = 0;
            directions = { ...
                [1;1;1;1], ...
                [1,1,1,1], ...
                [0 0 0 1
                0 0 1 0
                0 1 0 0
                1 0 0 0], ...
                [1 0 0 0
                0 1 0 0
                0 0 1 0
                0 0 0 1]};
            for player = 1:2
                for direction = directions
                    if any(any( conv2(b.*(b==player),direction{1},'same') == 4*player ))
                        r = player;
                        return
                    end
                end
            end
            
            if ~any(game.boardstate(:)==0)
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
        
    end
    
end % classdef