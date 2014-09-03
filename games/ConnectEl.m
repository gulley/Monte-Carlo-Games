classdef ConnectEl < ConnectFour
    
    methods
        
        function g = ConnectEl(initialBoardstate)
            % Constructor
            if nargin < 1
                initialBoardstate = zeros(6,7);
            end
            g.boardstate = initialBoardstate;
        end
        
        function newGame = copy(game)
            newGame = ConnectEl(game.boardstate);
        end
        
        function r = isGameOver(game)
            b = reshape(game.boardstate,6,7);
            
            % Code courtesy of @bmtran
            % See http://www.mathworks.com/matlabcentral/cody/problems/90-connect-four-win-checker/solutions/2314
            r = 0;
            directions = { ...
                [ ...
                1 1 0
                0 1 0
                0 1 0], ...
                [ ...
                0 1 1
                0 1 0
                0 1 0], ...
                [ ...
                0 1 0
                0 1 0
                1 1 0], ...
                [ ...
                0 1 0
                0 1 0
                0 1 1], ...
                [ ...
                0 0 1
                1 1 1
                0 0 0], ...
                [ ...
                0 0 0
                1 1 1
                0 0 1], ...
                [ ...
                1 0 0
                1 1 1
                0 0 0], ...
                [ ...
                0 0 0
                1 1 1
                1 0 0] ...
                };
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
        
    end
    
end % classdef