classdef ReversiTests < matlab.unittest.TestCase
    % ReversiTests Test class for Reversi game functionality (Othello)
    
    methods (TestClassSetup)
        function setupPath(testCase)
            % Initialize path for tests
            addpath(fullfile(fileparts(pwd), 'toolbox', 'internal'))
            initializePath()
        end
    end
    
    methods (Test)
        function testConstructor(testCase)
            % Test Reversi constructor
            g = Reversi;
            testCase.verifyClass(g, 'Reversi')
            testCase.verifyEqual(size(g.board), [6 6])
            % Check initial setup - should have 2x2 pattern in center
            expectedBoard = zeros(6,6);
            expectedBoard(3:4, 3:4) = [1 2; 2 1];
            testCase.verifyEqual(g.board, expectedBoard)
        end
        
        function testInitialState(testCase)
            % Test initial game state
            g = Reversi;
            testCase.verifyEqual(g.whoseMove, 1)
            testCase.verifyEqual(g.isGameOver, 0)
            % Should have some possible moves initially
            possibleMoves = g.possibleMoves;
            testCase.verifyNotEmpty(possibleMoves)
        end
        
        function testMakingValidMove(testCase)
            % Test making valid move
            g = Reversi;
            possibleMoves = g.possibleMoves;
            if ~isempty(possibleMoves)
                firstMove = possibleMoves(1);
                g.makeMove(firstMove, 1)
                testCase.verifyEqual(g.board(firstMove), 1)
                testCase.verifyEqual(g.whoseMove, 2)
            end
        end
        
        function testInvalidMoveOccupiedPosition(testCase)
            % Test invalid move to occupied position
            g = Reversi;
            % Try to move to center position that's already occupied
            g.makeMove(15, 1);  % Position 15 should be occupied in 6x6 board
            testCase.verifyEqual(g.whoseMove, 1)  % Should not change turn
        end
        
        function testVictoryByPieceCount(testCase)
            % Test victory by piece count
            g = Reversi;
            % Create a board where player 1 has more pieces
            g.board = ones(6,6);
            g.board(1:5) = 2;  % Player 2 has fewer pieces
            testCase.verifyEqual(g.isGameOver, 1)
            
            % Create a board where player 2 has more pieces
            g.board = 2 * ones(6,6);
            g.board(1:5) = 1;  % Player 1 has fewer pieces
            testCase.verifyEqual(g.isGameOver, 2)
        end
        
        function testDrawCondition(testCase)
            % Test draw condition
            g = Reversi;
            % Create a board with equal pieces
            g.board = ones(6,6);
            g.board(1:18) = 2;  % Equal number of pieces
            testCase.verifyEqual(g.isGameOver, 3)
        end
        
        function testGameContinues(testCase)
            % Test that fresh game continues
            g = Reversi;
            testCase.verifyEqual(g.isGameOver, 0)
        end
        
        function testPossibleMovesUpdate(testCase)
            % Test possible moves update after making move
            g = Reversi;
            initialMoves = g.possibleMoves;
            if ~isempty(initialMoves)
                g.makeMove(initialMoves(1), 1)
                newMoves = g.possibleMoves;
                % Moves should be different after making a move
                testCase.verifyNotEqual(initialMoves, newMoves)
            end
        end
        
        function testCopyFunction(testCase)
            % Test game copy functionality
            g = Reversi;
            g2 = g.copy;
            testCase.verifyEqual(g.board, g2.board)
            testCase.verifyNotEqual(g, g2)
        end
        
        function testBotIntegration(testCase)
            % Test bot vs bot gameplay
            g = Reversi;
            
            % Two robots play until the game is over
            nGamesSide1 = 5;
            nGamesSide2 = 5;
            maxMoves = 36;
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