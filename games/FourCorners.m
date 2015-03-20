classdef FourCorners < FourGameBase
        % Four Corners
        % The first player to four pieces in the corners of a rectangle loses.

    methods
        
        function g = FourCorners(initialboard)
            % Constructor
            if nargin < 1
                initialboard = zeros(6,7);
            end
            g.board = initialboard;
        end
        
        function newGame = copy(game)
            newGame = FourCorners(game.board);
        end
        
        function result = isGameOver(game)
            b = game.board;
            
            % Code courtesy of Alfonso Nieto-Castanon
            % See http://www.mathworks.com/matlabcentral/cody/problems/512-spot-the-rectangle/solutions/63821
            result = 0;
            
            b1 = double(b==1);
            tr1 = triu((b1' * b1)>1, 1);
            if any(tr1(:))
                result = 2;
                return
            end
            
            b2 = double(b==2);
            tr2 = triu((b2' * b2)>1, 1);
            if any(tr2(:))
                result = 1;
                return
            end
            
            if all(b(:))
                result = 3;
            end
            
        end
        
    end
    
end 