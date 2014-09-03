classdef FourCorners < FourGameBase
    
    methods
        
        function g = FourCorners(initialBoardstate)
            % Constructor
            if nargin < 1
                initialBoardstate = zeros(6,7);
            end
            g.boardstate = initialBoardstate;
        end
        
        function newGame = copy(game)
            newGame = FourCorners(game.boardstate);
        end
        
        function r = isGameOver(game)
            b = game.boardstate;
            
            % Code courtesy of Alfonso Nieto-Castanon
            % See http://www.mathworks.com/matlabcentral/cody/problems/512-spot-the-rectangle/solutions/63821
            r = 0;
            
            b1 = double(b==1);
            tr1 = triu( (b1' * b1)>1, 1);
            if any(tr1(:))
                r = 2;
                return
            end
            
            b2 = double(b==2);
            tr2 = triu( (b2' * b2)>1, 1);
            if any(tr2(:))
                r = 1;
                return
            end
            
            if all(b(:))
                r = 3;
            end
            
        end
        
    end
    
end % classdef