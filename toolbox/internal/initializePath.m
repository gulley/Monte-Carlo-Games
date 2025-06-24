function initializePath
    % Initialize MATLAB path for Monte Carlo Games project
    
    % Get the directory where this file is located (toolbox/internal)
    currentDir = fileparts(mfilename('fullpath'));
    
    % Get project root (two levels up from toolbox/internal)
    projectRoot = fileparts(fileparts(currentDir));
    
    % Get toolbox directory (one level up from internal)
    toolboxDir = fileparts(currentDir);
    
    % Add project directories to path
    addpath(fullfile(toolboxDir, 'games'))         % toolbox/games
    addpath(fullfile(projectRoot, 'demos'))        % demos (at root)
    addpath(toolboxDir)                            % toolbox (main functions)
    addpath(projectRoot)                           % project root
end