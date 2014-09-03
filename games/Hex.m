classdef Hex < handle
    
    properties
        boardstate
    end
    
    properties (Constant = true)
        adj = makeHexAdjMatrix(9)
    end
    
    methods
        % Hex
        % The Hex board is managed as an 11x11 matrix
        % See http://en.wikipedia.org/wiki/Hex_(board_game)
        
        % boardstate:  11x11 matrix with 0=empty, 1=red, 2=blue
        % adj:         125x125 adjacency matrix for determining the winner
        % boardmask:   11x11 matrix with logical to indicate open moves
        % poslist:     column vector of board positions (1-121 index into board)
        % pos:         a single position from the poslist
        % outcomelist: associates wins and ties with each possible move
        
        % =================================================================
        function g = Hex(initialBoardstate)
            % Constructor
            nCells = sqrt(size(g.adj,1) - 4);
            
            if nargin < 1
                initialBoardstate = zeros(nCells);
            end
            g.boardstate = initialBoardstate;
            
        end
        
        function newGame = copy(game)
            newGame = Hex(game.boardstate);
        end
        
        function showResult(game)
            game.showBoard;
            r = game.isGameOver;
            % Hex can never end in a tie.
            if r==1
                fprintf('Red wins.\n')
            elseif r==2
                fprintf('Blue wins.\n')
            end
        end
        
        function side = whoseMove(game)
            % If there are the same number of reds as blues, then red goes
            % next.
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
            
            sz = size(game.boardstate);
            nCells = sz(1);
            nCellsSq = nCells^2;
            
            % Short-circuit and return if no win yet possible
            if sum(game.boardstate(:)==1) < nCells
                % If you haven't played enough pieces to cross the board,
                % it's not possible for either side to have won.
                r = 0;
                return
            end
            
            % Test for Side 1 victory
            a = game.adj;
            side1 = [find(game.boardstate==1); nCellsSq+1; nCellsSq+2];
            side = side1;
            len = length(side);
            a = a(side,side);
            dist = graphshortestpath(a,len-1,len);
            if ~isinf(dist)
                r = 1;
                return
            end
            
            % Test for Side 1 victory
            a = game.adj;
            side2 = [find(game.boardstate==2); nCellsSq+3; nCellsSq+4];
            side = side2;
            len = length(side);
            a = a(side,side);
            dist = graphshortestpath(a,len-1,len);
            if ~isinf(dist)
                r = 2;
                return
            end
            
            r = 0;
            
        end
        
        function showBoard(g)
            % Display method
            
            % The geometry of a single hex cell
            rt1over5 = 1/sqrt(5);
            rt4over5 = 2*rt1over5;
            xy = [ ...
                rt4over5 rt1over5;
                0 1;
                -rt4over5 rt1over5;
                -rt4over5 -rt1over5;
                0 -1;
                rt4over5 -rt1over5;
                rt4over5 rt1over5];
            
            clf
            sz = size(g.boardstate);
            nCells = sz(1);
            h = zeros(nCells);
            showText = true;
            
            for c = 1:nCells
                for r = 1:nCells
                    x = c*2*rt4over5+r*rt4over5;
                    y = -r*(1+rt1over5);
                    
                    if g.boardstate(r,c)==1
                        color = [1 0.5 0.5];
                    elseif g.boardstate(r,c)==2
                        color = [0.5 0.5 1];
                    else
                        color = [1 1 1];
                    end
                    
                    h(c,r) = patch(xy(:,1)+x, ...
                        xy(:,2)+y,color);
                    
                    if showText
                        me = sub2ind(sz,r,c);
                        % text(x,y,sprintf('%d (%d,%d)',me,r,c),'HorizontalAlignment','center');
                        text(x,y,sprintf('%d',me),'HorizontalAlignment','center');
                    end
                    
                end
                
            end
            
            axis off
            axis equal
            
        end
        
    end % methods
    
end % classdef


function adj = makeHexAdjMatrix(nCells)
    
    sz = [nCells nCells];
    adj = sparse(nCells^2+4,nCells^2+4);
    for c = 1:nCells
        for r = 1:nCells
            % Wire up the connectivity matrix for cell adjacencies
            me = sub2ind(sz,r,c);
            if r>1
                aboveLeft = sub2ind(sz,r-1,c);
                adj(me,aboveLeft) = 1;
            end
            if (c<nCells) && (r>1)
                aboveRight = sub2ind(sz,r-1,c+1);
                adj(me,aboveRight) = 1;
            end
            if c<nCells
                right = sub2ind(sz,r,c+1);
                adj(me,right) = 1;
            end
        end
    end
    
    % Now add the border "supernodes"
    % These help us determine which player has won
    leftBorder = sub2ind(sz,1:nCells,ones(1,nCells));
    rightBorder = sub2ind(sz,1:nCells,nCells*ones(1,nCells));
    topBorder = sub2ind(sz,ones(1,nCells),1:nCells);
    bottomBorder = sub2ind(sz,nCells*ones(1,nCells),1:nCells);
    adj(nCells^2+1,leftBorder) = 1;
    adj(nCells^2+2,rightBorder) = 1;
    adj(nCells^2+3,topBorder) = 1;
    adj(nCells^2+4,bottomBorder) = 1;
    
    % Make the connectivity matrix symmetric
    adj = sign(adj+adj');
    
    
end