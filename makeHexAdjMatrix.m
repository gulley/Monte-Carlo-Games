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