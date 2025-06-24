classdef FourCornersTests < matlab.unittest.TestCase
    % FourCornersTests Test class for FourCorners game functionality (first to get 4 corners of rectangle LOSES)
    
    methods (TestClassSetup)
        function setupPath(testCase)
            % Initialize path for tests
            addpath(fullfile(fileparts(pwd), 'toolbox', 'internal'))
            initializePath()
        end
    end
    
    methods (Test)
        function testConstructor(testCase)
            % Test FourCorners constructor
            g = FourCorners;
            testCase.verifyClass(g, 'FourCorners')
            testCase.verifyEqual(size(g.board), [6 7])
            testCase.verifyTrue(all(g.board(:) == 0))
        end
        
        function testInheritance(testCase)
            % Test inheritance from FourGameBase
            g = FourCorners;
            testCase.verifyClass(g, 'FourGameBase')
        end
        
        function testInitialState(testCase)
            % Test initial game state
            g = FourCorners;
            testCase.verifyEqual(g.whoseMove, 1)
            testCase.verifyEqual(g.possibleMoves, 1:7)
            testCase.verifyEqual(g.isGameOver, 0)
        end
        
        function testFourCornersLosingPlayer1(testCase)
            % Test four corners losing - Player 1 loses
            g = FourCorners;
            % Create rectangle with player 1 pieces at corners
            g.board(4, [2 5]) = 1;  % Top corners of rectangle
            g.board(6, [2 5]) = 1;  % Bottom corners of rectangle
            % Player 1 should lose (result = 2)
            testCase.verifyEqual(g.isGameOver, 2)
        end
        
        function testFourCornersLosingPlayer2(testCase)
            % Test four corners losing - Player 2 loses  
            g = FourCorners;
            % Create rectangle with player 2 pieces at corners
            g.board(3, [1 4]) = 2;  % Top corners of rectangle
            g.board(5, [1 4]) = 2;  % Bottom corners of rectangle
            % Player 2 should lose (result = 1)
            testCase.verifyEqual(g.isGameOver, 1)
        end
        
        function testNoRectangleYet(testCase)
            % Test no rectangle condition
            g = FourCorners;
            % Place pieces that don't form rectangle corners
            g.board(6, [1 3 5]) = 1;
            g.board(5, [2 4]) = 2;
            testCase.verifyEqual(g.isGameOver, 0)
        end
        
        function testDrawCondition(testCase)
            % Test draw condition with board full
            g = FourCorners;
            % Fill entire board without creating rectangles
            % Use checkerboard pattern to avoid rectangles
            for r = 1:6
                for c = 1:7
                    g.board(r,c) = mod(r+c, 2) + 1;
                end
            end
            % Should be a draw
            testCase.verifyEqual(g.isGameOver, 3)
        end
        
        function testRectangleDetectionAlgorithm(testCase)
            % Test the matrix multiplication detection
            g = FourCorners;
            % Create a minimal rectangle
            g.board(4, [2 4]) = 1;
            g.board(6, [2 4]) = 1;
            % This should trigger rectangle detection for player 1
            testCase.verifyEqual(g.isGameOver, 2)  % Player 1 loses
        end
        
        function testCopyFunction(testCase)
            % Test game copy functionality
            g = FourCorners;
            g.board(6, 1:3) = [1 2 1];
            g2 = g.copy;
            testCase.verifyEqual(g.board, g2.board)
            testCase.verifyNotEqual(g, g2)
        end
        
        function testBotIntegration(testCase)
            % Test bot vs bot gameplay
            g = FourCorners;
            
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