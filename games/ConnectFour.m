classdef ConnectFour < FourGameBase
    % Connect Four
    % The Connect Four board is managed as a  6x7 matrix
    
    % boardstate:  6x7 matrix with 0=empty, 1=red, 2=black
    % boardmask:   1x7 vector with logical to indicate open moves
    % poslist:     column vector of board positions (1-7 index into board)
    % pos:         a single position from the poslist
    % outcomelist: associates wins and ties with each possible move
    
    methods
        
        function g = ConnectFour(initialBoardstate)
            % Constructor
            if nargin < 1
                initialBoardstate = zeros(6,7);
            end
            g.boardstate = initialBoardstate;
        end
        
        function newGame = copy(game)
            newGame = ConnectFour(game.boardstate);
        end
        
        function r = isGameOver(game)
            b = game.boardstate;
            
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