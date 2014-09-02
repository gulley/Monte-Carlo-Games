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
        
        function side = whoseMove(game)
            % If there are the same number of Xs and Os, then X goes next.
            if sum(game.boardstate(:)==1) == sum(game.boardstate(:)==2)
                side = 1;
            else
                side = 2;
            end
        end
        
        function moves = possibleMoves(game)
            % Where are the legal moves?
            moves = find(game.boardstate==0);
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
        end 
        
        function showBoardGraphical(g)
            
            b = reshape(g.boardstate,3,3);
            
            clf
            for r=1:3
                for c=1:3
                    switch b(r,c)
                        case 1
                            markerStr = 'x';
                            colorStr = 'black';
                        case 2
                            markerStr = 'o';
                            colorStr = 'blue';
                        otherwise
                            markerStr = 'none';
                            colorStr = 'white';
                    end
                    line(c-0.5,r-0.5,'Marker',markerStr,'MarkerSize',50, ...
                        'MarkerEdgeColor',colorStr,'LineWidth',3);
                    
                end
            end
            axis ij
            axis([0 3 0 3])
            axis square
            set(gca,'XTick',0:3,'YTick',0:3)
            set(gca,'XTickLabel',[],'YTickLabel',[])
            grid on
            box on
            drawnow
            
        end
        
    end
    
end % classdef