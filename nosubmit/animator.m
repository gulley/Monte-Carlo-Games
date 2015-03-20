function animator(gifFileName,option)
    % option = {'first','add'}
    
    if strcmp(option,'first')
        % Animation initialization
        firstFrame = true;
        htmlDir = fullfile(pwd,'html');
        if ~exist(htmlDir,'dir')
            mkdir(pwd,'html');
        end
    elseif strcmp(option,'add')
        firstFrame = false;
    else
        error('Unknown option %s',option)
    end
    
    % Save a frame
    delayTime = 3/4;
    animFilename = fullfile(pwd,'html',gifFileName);
    im = getframe(gcf);
    [A,map] = rgb2ind(im.cdata,256);
    if firstFrame
        firstFrame = false;
        imwrite(A,map,animFilename,'LoopCount',Inf,'DelayTime',delayTime);
    else
        imwrite(A,map,animFilename,'WriteMode','append','DelayTime',delayTime);
    end
    
end