classdef ConnectEl < FourGameBase
        % Connect El
        % The first player to four pieces in an L shape wins.

    methods
        
        function g = ConnectEl(initialboard)
            % Constructor
            if nargin < 1
                initialboard = zeros(6,7);
            end
            g.board = initialboard;
        end
        
        function newGame = copy(game)
            newGame = ConnectEl(game.board);
        end
        
        function result = isGameOver(game)
            b = reshape(game.board,6,7);
            
            % Code courtesy of @bmtran
            % See http://www.mathworks.com/matlabcentral/cody/problems/90-connect-four-win-checker/solutions/2314
            result = 0;
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
                        result = player;
                        return
                    end
                end
            end
            
            if ~any(game.board(:)==0)
                result = 3;
            end
            
        end
        
    end
    
end 