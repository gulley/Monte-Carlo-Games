classdef Reversi < handle
    % Reversi (also known as Othello)
    
    properties
        board
    end
    
    methods
        
        function g = Reversi(initialboard)
            % Constructor
            if nargin < 1
                n = 6;
                nHalf = n/2;
                initialboard = zeros(n);
                initialboard((0:1)+n/2,(0:1)+n/2) = [1 2; 2 1];
            end
            g.board = initialboard;
        end
        
        function newGame = copy(game)
            newGame = Reversi(game.board);
        end
                
        function side = whoseMove(game)
            if ~rem(nnz(game.board),2)
                side = 1;
            else
                side = 2;
            end
        end
        
        function moves = possibleMoves(game)
            % Where are the legal moves?
            b = game.board;
            s = game.whoseMove;
            
            % This code courtesy of Tim
            % http://www.mathworks.com/matlabcentral/cody/problems/2538-find-the-next-legal-move-in-reversi/solutions/495060
            
            n=length(b);
            B=blkdiag(0*b,b,0*b);
            d=[1 3*n+(-1:1)];
            m = [];
            for k = find(~b)'
                K = k+n*(3*n+1+2*floor((k-1)/n));
                for h = [-d d]
                    a = B(K+h*(1:n));
                    i = find(a==s,1);
                    if any(i>1) && all(a(1:i-1)==3-s)
                        m = [m k];
                        break;
                    end
                end
            end
            
            moves = m;
        end
        
        function makeMove(game, move, side)
            
            % Code courtesy of Jan Orwat
            % http://www.mathworks.com/matlabcentral/cody/problems/2565-determine-the-result-of-a-move-in-reversi/solutions/498034
            
            board = game.board;
            
            borders=size(board);
            ind=@(SUBS)sub2ind(borders,SUBS(1),SUBS(2));
            [M, M(2,1)]=ind2sub(borders,move);
            board(move)=side;
            
            function TF=flank(C,mode)
                TF=false;
                while all([C<=borders'; C>0])&&board(ind(C))&&~TF
                    TF=board(ind(C))==side;
                    if mode
                        board(ind(C))=side;
                    end
                    C=C+n;
                end
            end
            
            for n=[ 0  1  1  1  0 -1 -1 -1
                    -1 -1  0  1  1  1  0 -1];
                if flank(M+n,0)
                    flank(M+n,1);
                end
            end
            
            game.board = board;
            
        end
        
        function r = isGameOver(game)
            
            m = game.possibleMoves;
            
            if ~isempty(m)
                r = 0;
                return
            end
            
            board = game.board;
            nBlack = sum(board(:)==1);
            nWhite = sum(board(:)==2);
            
            if nBlack > nWhite
                r = 1;
            elseif nWhite > nBlack
                r = 2;
            else
                r = 3;
            end
            
        end
        
        function showBoard(game)
            
            board = game.board;
            sz = size(board);
            n = sz(1);
            m = game.possibleMoves;
            
            clf
            for r=1:n
                for c=1:n
                    switch board(r,c)
                        case 1
                            markerStr = 'o';
                            colorStr = 'black';
                        case 2
                            markerStr = 'o';
                            colorStr = 'white';
                        otherwise
                            markerStr = 'none';
                            colorStr = 'white';
                            ix = sub2ind(sz,r,c);
                            if ismember(ix,m)
                                text(c-0.5,r-0.5,num2str(ix), ...
                                    'Color',0.5*[1 1 1], ...
                                    'FontSize',15, ...
                                    'HorizontalAlignment','center')
                            end
                            
                    end
                    line(c-0.5,r-0.5,'Marker',markerStr,'MarkerSize',30, ...
                        'MarkerEdgeColor',0.5*[1 1 1],'MarkerFaceColor',colorStr);
                    
                end
            end
            axis ij
            axis([0 n 0 n])
            set(gca,'XTick',0:n,'YTick',0:n)
            set(gca,'XTickLabel',[],'YTickLabel',[])
            set(gca,'Color',[150 255 150]/255)
            grid on
            box on
            axis square
            drawnow
            
            result = game.isGameOver;
            if result==1
                title('Black wins')
            elseif result==2
                title('White wins')
            elseif result==3
                title('Tie game')
            end
            
        end
        
    end
    
end