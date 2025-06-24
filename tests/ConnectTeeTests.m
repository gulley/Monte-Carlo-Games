classdef ConnectTeeTests < matlab.unittest.TestCase
    % ConnectTeeTests Test class for ConnectTee game functionality (4 pieces in T shape wins)
    
    methods (TestClassSetup)
        function setupPath(testCase)
            % Initialize path for tests
            addpath(fullfile(fileparts(pwd), 'toolbox', 'internal'))
            initializePath()
        end
    end
    
    methods (Test)
        function testConstructor(testCase)
            % Test ConnectTee constructor
            g = ConnectTee;
            testCase.verifyClass(g, 'ConnectTee')
            testCase.verifyEqual(size(g.board), [6 7])
            testCase.verifyTrue(all(g.board(:) == 0))
        end
        
        function testInheritance(testCase)
            % Test inheritance from FourGameBase
            g = ConnectTee;
            testCase.verifyClass(g, 'FourGameBase')
        end
        
        function testInitialState(testCase)
            % Test initial game state
            g = ConnectTee;
            testCase.verifyEqual(g.whoseMove, 1)
            testCase.verifyEqual(g.possibleMoves, 1:7)
            testCase.verifyEqual(g.isGameOver, 0)
        end
        
        function testTShapeVictoryUpright(testCase)
            % Test T-shape victory - upright T
            g = ConnectTee;
            % Create T-shape: horizontal top with vertical stem
            g.board(5, 2:4) = 1;  % Horizontal top
            g.board(6, 3) = 1;    % Vertical stem
            % This should trigger T-shape detection
            testCase.verifyEqual(g.isGameOver, 1)
        end
        
        function testTShapeVictoryInverted(testCase)
            % Test T-shape victory - inverted T
            g = ConnectTee;
            % Create inverted T-shape
            g.board(6, 2:4) = 1;  % Horizontal bottom
            g.board(5, 3) = 1;    % Vertical stem up
            % This should trigger T-shape detection
            testCase.verifyEqual(g.isGameOver, 1)
        end
        
        function testTShapeVictoryLeft(testCase)
            % Test T-shape victory - left T
            g = ConnectTee;
            % Create left-facing T-shape
            g.board(4:6, 3) = 1;  % Vertical part
            g.board(5, 4) = 1;    % Horizontal extension right
            % This should trigger T-shape detection
            testCase.verifyEqual(g.isGameOver, 1)
        end
        
        function testTShapeVictoryRight(testCase)
            % Test T-shape victory - right T
            g = ConnectTee;
            % Create right-facing T-shape
            g.board(4:6, 4) = 1;  % Vertical part
            g.board(5, 3) = 1;    % Horizontal extension left
            % This should trigger T-shape detection
            testCase.verifyEqual(g.isGameOver, 1)
        end
        
        function testNoVictoryYet(testCase)
            % Test no victory condition
            g = ConnectTee;
            g.board(6, 2:4) = 1;  % Just horizontal line, no T
            testCase.verifyEqual(g.isGameOver, 0)
        end
        
        function testCopyFunction(testCase)
            % Test game copy functionality
            g = ConnectTee;
            g.board(6, 2:4) = [1 2 1];
            g2 = g.copy;
            testCase.verifyEqual(g.board, g2.board)
            testCase.verifyNotEqual(g, g2)
        end
        
        function testBotIntegration(testCase)
            % Test bot vs bot gameplay
            g = ConnectTee;
            
            % Two robots play until the game is over
            nGamesSide1 = 10;
            nGamesSide2 = 10;
            maxMoves = 42;  % 6x7 board
            moveCount = 0;
            
            while ~g.isGameOver && moveCount < maxMoves
                moves1 = g.possibleMoves;
                if ~isempty(moves1)
                    botMoves(g, nGamesSide1)
                    moveCount = moveCount + 1;
                else
                    break
                end
                
                if ~g.isGameOver && moveCount < maxMoves
                    moves2 = g.possibleMoves;
                    if ~isempty(moves2)
                        botMoves(g, nGamesSide2)
                        moveCount = moveCount + 1;
                    else
                        break
                    end
                end
            end
            
            % Game should be over
            testCase.verifyGreaterThan(g.isGameOver, 0)
        end
    end
end