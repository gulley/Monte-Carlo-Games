classdef OxoTests < matlab.unittest.TestCase
    % OxoTests Test class for Oxo game functionality (reverse tic-tac-toe where OXO pattern wins)
    
    methods (TestClassSetup)
        function setupPath(testCase)
            % Initialize path for tests
            addpath(fullfile(fileparts(pwd), 'toolbox', 'internal'))
            initializePath()
        end
    end
    
    methods (Test)
        function testConstructor(testCase)
            % Test Oxo constructor
            g = Oxo;
            testCase.verifyClass(g, 'Oxo')
            testCase.verifyEqual(size(g.board), [6 6])
            testCase.verifyTrue(all(g.board(:) == 0))
        end
        
        function testInitialState(testCase)
            % Test initial game state
            g = Oxo;
            % In Oxo, O goes first (side 2)
            testCase.verifyEqual(g.whoseMove, 2)
            testCase.verifyEqual(g.possibleMoves, 1:36)
            testCase.verifyEqual(g.isGameOver, 0)
        end
        
        function testMakingMoves(testCase)
            % Test making valid moves
            g = Oxo;
            g.makeMove(1, 2)
            testCase.verifyEqual(g.board(1), 2)
            testCase.verifyEqual(g.whoseMove, 1)
            
            g.makeMove(2, 1)
            testCase.verifyEqual(g.board(2), 1)
            testCase.verifyEqual(g.whoseMove, 2)
        end
        
        function testOccupiedPosition(testCase)
            % Test moving to occupied position
            g = Oxo;
            g.makeMove(1, 2)
            % Try to move to same position - should not change board
            g.makeMove(1, 1)
            testCase.verifyEqual(g.board(1), 2)
            testCase.verifyEqual(g.whoseMove, 1)
        end
        
        function testVictoryConditionHorizontalOXO(testCase)
            % Test horizontal OXO victory condition
            g = Oxo;
            % Create horizontal OXO pattern (O=2, X=1)
            g.board(1:3) = [2 1 2];
            % Player who just moved wins, so if O moved last, O wins
            % Since whoseMove alternates, if current turn is X(1), then O(2) just moved
            g.board(4) = 1;  % Force whoseMove to be 2
            testCase.verifyEqual(g.isGameOver, 2)
        end
        
        function testVictoryConditionVerticalOXO(testCase)
            % Test vertical OXO victory condition
            g = Oxo;
            % Create vertical OXO pattern
            g.board([1 7 13]) = [2 1 2];
            g.board(2) = 1;  % Force whoseMove to be 2
            testCase.verifyEqual(g.isGameOver, 2)
        end
        
        function testNoVictoryYet(testCase)
            % Test no victory condition
            g = Oxo;
            g.board(1:3) = [2 1 1];  % Not OXO pattern
            testCase.verifyEqual(g.isGameOver, 0)
        end
        
        function testDrawCondition(testCase)
            % Test draw condition with full board
            g = Oxo;
            % Fill board without OXO pattern
            g.board = ones(6,6);
            g.board(1:2:36) = 2;  % Alternating pattern to avoid OXO
            testCase.verifyEqual(g.isGameOver, 3)
        end
        
        function testPossibleMoves(testCase)
            % Test possible moves calculation
            g = Oxo;
            g.board(1:10) = [2 1 2 1 2 1 2 1 2 1];
            possibleMoves = g.possibleMoves;
            testCase.verifyEqual(possibleMoves, 11:36)
        end
        
        function testCopyFunction(testCase)
            % Test game copy functionality
            g = Oxo;
            g.board(1:5) = [2 1 2 1 2];
            g2 = g.copy;
            testCase.verifyEqual(g.board, g2.board)
            testCase.verifyNotEqual(g, g2)
        end
        
        function testBotIntegration(testCase)
            % Test bot vs bot gameplay
            g = Oxo;
            
            % Two robots play until the game is over
            nGamesSide1 = 10;
            nGamesSide2 = 10;
            maxMoves = 36;
            moveCount = 0;
            
            while ~g.isGameOver && moveCount < maxMoves
                botMoves(g, nGamesSide1)
                moveCount = moveCount + 1;
                
                if ~g.isGameOver && moveCount < maxMoves
                    botMoves(g, nGamesSide2)
                    moveCount = moveCount + 1;
                end
            end
            
            % Game should be over
            testCase.verifyGreaterThan(g.isGameOver, 0)
        end
    end
end