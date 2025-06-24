classdef ConnectElTests < matlab.unittest.TestCase
    % ConnectElTests Test class for ConnectEl game functionality (4 pieces in L shape wins)
    
    methods (TestClassSetup)
        function setupPath(testCase)
            % Initialize path for tests
            addpath(fullfile(fileparts(pwd), 'toolbox', 'internal'))
            initializePath()
        end
    end
    
    methods (Test)
        function testConstructor(testCase)
            % Test ConnectEl constructor
            g = ConnectEl;
            testCase.verifyClass(g, 'ConnectEl')
            testCase.verifyEqual(size(g.board), [6 7])
            testCase.verifyTrue(all(g.board(:) == 0))
        end
        
        function testInheritance(testCase)
            % Test inheritance from FourGameBase
            g = ConnectEl;
            testCase.verifyClass(g, 'FourGameBase')
        end
        
        function testInitialState(testCase)
            % Test initial game state
            g = ConnectEl;
            testCase.verifyEqual(g.whoseMove, 1)
            testCase.verifyEqual(g.possibleMoves, 1:7)
            testCase.verifyEqual(g.isGameOver, 0)
        end
        
        function testPiecesDrop(testCase)
            % Test that pieces drop to bottom
            g = ConnectEl;
            g.makeMove(1, 1)
            testCase.verifyEqual(g.board(6,1), 1)  % Piece should drop to bottom
            testCase.verifyEqual(g.whoseMove, 2)
            
            g.makeMove(1, 2)
            testCase.verifyEqual(g.board(5,1), 2)  % Next piece stacks on top
            testCase.verifyEqual(g.whoseMove, 1)
        end
        
        function testFullColumn(testCase)
            % Test full column handling
            g = ConnectEl;
            % Fill column 1 completely
            for i = 1:6
                g.makeMove(1, mod(i-1,2)+1)
            end
            % Column should be full
            testCase.verifyNotEqual(prod(g.board(:,1)), 0)
            % Should not be able to make more moves in column 1
            possibleMoves = g.possibleMoves;
            testCase.verifyFalse(ismember(1, possibleMoves))
        end
        
        function testLShapeVictoryVertical(testCase)
            % Test L-shape victory - vertical L
            g = ConnectEl;
            % Create L-shape: vertical line with horizontal extension
            g.board(3:6, 1) = 1;  % Vertical part
            g.board(6, 2) = 1;    % Horizontal extension
            % This should trigger L-shape detection
            testCase.verifyEqual(g.isGameOver, 1)
        end
        
        function testLShapeVictoryHorizontal(testCase)
            % Test L-shape victory - horizontal L
            g = ConnectEl;
            % Create horizontal L-shape
            g.board(6, 1:3) = 1;  % Horizontal part
            g.board(5, 3) = 1;    % Vertical extension
            % This should trigger L-shape detection  
            testCase.verifyEqual(g.isGameOver, 1)
        end
        
        function testNoVictoryYet(testCase)
            % Test no victory condition
            g = ConnectEl;
            g.board(6, 1:3) = 1;  % Just horizontal line, no L
            testCase.verifyEqual(g.isGameOver, 0)
        end
        
        function testCopyFunction(testCase)
            % Test game copy functionality
            g = ConnectEl;
            g.board(6, 1:3) = [1 2 1];
            g2 = g.copy;
            testCase.verifyEqual(g.board, g2.board)
            testCase.verifyNotEqual(g, g2)
        end
        
        function testBotIntegration(testCase)
            % Test bot vs bot gameplay
            g = ConnectEl;
            
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