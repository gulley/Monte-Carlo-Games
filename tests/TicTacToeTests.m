classdef TicTacToeTests < matlab.unittest.TestCase
    % TicTacToeTests Test class for TicTacToe game functionality
    
    methods (TestClassSetup)
        function setupPath(testCase)
            % Initialize path for tests
            addpath(fullfile(fileparts(pwd), 'toolbox', 'internal'))
            initializePath()
        end
    end
    
    methods (Test)
        function testConstructor(testCase)
            % Test TicTacToe constructor
            g = TicTacToe;
            testCase.verifyClass(g, 'TicTacToe')
            testCase.verifyEqual(size(g.board), [3 3])
            testCase.verifyTrue(all(g.board(:) == 0))
        end
        
        function testInitialState(testCase)
            % Test initial game state
            g = TicTacToe;
            testCase.verifyEqual(g.whoseMove, 1)
            testCase.verifyEqual(g.possibleMoves, 1:9)
            testCase.verifyEqual(g.isGameOver, 0)
        end
        
        function testMakingMoves(testCase)
            % Test making valid moves
            g = TicTacToe;
            g.makeMove(1, 1)
            testCase.verifyEqual(g.board(1), 1)
            testCase.verifyEqual(g.whoseMove, 2)
            
            g.makeMove(2, 2)
            testCase.verifyEqual(g.board(2), 2)
            testCase.verifyEqual(g.whoseMove, 1)
        end
        
        function testOccupiedPosition(testCase)
            % Test moving to occupied position
            g = TicTacToe;
            g.makeMove(1, 1)
            % Try to move to same position - should not change board
            g.makeMove(1, 2)
            testCase.verifyEqual(g.board(1), 1)
            testCase.verifyEqual(g.whoseMove, 2)
        end
        
        function testVictoryConditionsRows(testCase)
            % Test row victory conditions
            g = TicTacToe;
            g.board = [1 1 1; 0 0 0; 0 0 0];
            testCase.verifyEqual(g.isGameOver, 1)
            
            g.board = [0 0 0; 2 2 2; 0 0 0];
            testCase.verifyEqual(g.isGameOver, 2)
        end
        
        function testVictoryConditionsColumns(testCase)
            % Test column victory conditions
            g = TicTacToe;
            g.board = [1 0 0; 1 0 0; 1 0 0];
            testCase.verifyEqual(g.isGameOver, 1)
            
            g.board = [0 2 0; 0 2 0; 0 2 0];
            testCase.verifyEqual(g.isGameOver, 2)
        end
        
        function testVictoryConditionsDiagonals(testCase)
            % Test diagonal victory conditions
            g = TicTacToe;
            g.board = [1 0 0; 0 1 0; 0 0 1];
            testCase.verifyEqual(g.isGameOver, 1)
            
            g.board = [0 0 2; 0 2 0; 2 0 0];
            testCase.verifyEqual(g.isGameOver, 2)
        end
        
        function testDrawCondition(testCase)
            % Test draw condition
            g = TicTacToe;
            g.board = [1 2 1; 2 2 1; 2 1 2];
            testCase.verifyEqual(g.isGameOver, 3)
        end
        
        function testPossibleMoves(testCase)
            % Test possible moves calculation
            g = TicTacToe;
            g.board = [1 2 0; 2 1 0; 0 0 0];
            possibleMoves = g.possibleMoves;
            testCase.verifyEqual(sort(possibleMoves), [3 6 7 8 9])
        end
        
        function testCopyFunction(testCase)
            % Test game copy functionality
            g = TicTacToe;
            g.board = [1 2 0; 2 1 0; 0 0 0];
            g2 = g.copy;
            testCase.verifyEqual(g.board, g2.board)
            testCase.verifyNotEqual(g, g2)
        end
        
        function testBotIntegration(testCase)
            % Test bot vs bot gameplay
            g = TicTacToe;
            
            % Two robots play until the game is over
            nGamesSide1 = 10;
            nGamesSide2 = 10;
            maxMoves = 9;
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