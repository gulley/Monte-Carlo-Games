classdef ConnectFour < FourGameBase
    % Connect Four
    % The first player to get four in a row wins.
    
    methods
        
        function g = ConnectFour(initialBoard)
            % Constructor
            if nargin < 1
                initialBoard = zeros(6,7);
            end
            g.board = initialBoard;
        end
        
        function newGame = copy(game)
            newGame = ConnectFour(game.board);
        end
        
        function result = isGameOver(game)
            b = game.board;
            
            % Code courtesy of @bmtran
            % See http://www.mathworks.com/matlabcentral/cody/problems/90-connect-four-win-checker/solutions/2314
            result = 0;
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