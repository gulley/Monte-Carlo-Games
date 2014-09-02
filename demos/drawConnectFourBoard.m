function drawConnectFourBoard(board,style)
    % Display method
    if nargin < 2
        % style='text';
        style='graphical';
    end
    
    if strcmp(style,'text')
        showBoardText(board)
    elseif strcmp(style,'graphical')
        showBoardGraphical(board)
    end
    
end

function showBoardText(board)
    
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

function showBoardGraphical(board)
    
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
