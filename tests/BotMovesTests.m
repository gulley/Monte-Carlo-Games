classdef BotMovesTests < matlab.unittest.TestCase
    % BotMovesTests Test class for Monte Carlo bot decision-making functionality
    
    methods (TestClassSetup)
        function setupPath(testCase)
            % Initialize path for tests
            addpath(fullfile(fileparts(pwd), 'toolbox', 'internal'))
            initializePath()
        end
    end
    
    methods (Test)
        function testBotMovesBasicFunctionality(testCase)
            % Test basic botMoves functionality
            g = ConnectFour;
            initialBoard = g.board;
            botMoves(g, 100)
            % Board should have changed
            testCase.verifyNotEqual(g.board, initialBoard)
            % Should have exactly one more piece
            testCase.verifyEqual(nnz(g.board), nnz(initialBoard) + 1)
        end
        
        function testBotMovesNoMovesAvailable(testCase)
            % Test botMoves with no moves available
            g = ConnectFour;
            % Fill the entire board
            g.board = ones(6,7);
            % Should handle gracefully with no available moves
            botMoves(g, 100)
            % Board should remain unchanged
            testCase.verifyTrue(all(g.board(:) == 1))
        end
        
        function testBotMovesSingleMoveAvailable(testCase)
            % Test botMoves with single move available
            g = ConnectFour;
            % Fill all columns except one
            g.board(:, 1:6) = 1;
            botMoves(g, 100)
            % Should make the only available move
            testCase.verifyEqual(g.board(6,7), 1)
        end
        
        function testBotMovesRandomness(testCase)
            % Test botMoves determinism vs randomness
            g1 = TicTacToe;
            g2 = TicTacToe;
            
            % With many simulations, bot should make reasonable moves
            botMoves(g1, 1000)
            botMoves(g2, 1000)
            
            % Both should have made moves
            testCase.verifyEqual(nnz(g1.board), 1)
            testCase.verifyEqual(nnz(g2.board), 1)
        end
        
        function testBotStrategyWinningMove(testCase)
            % Test bot strategy - winning move detection
            g = TicTacToe;
            % Set up board where player 1 can win in one move
            g.board = [1 1 0; 2 2 0; 0 0 0];
            % Force it to be player 1's turn
            g.board(7) = 2;  % Add piece to make it player 1's turn
            
            botMoves(g, 100)
            % Bot should win by playing position 3
            testCase.verifyEqual(g.board(3), 1)
            testCase.verifyEqual(g.isGameOver, 1)
        end
        
        function testBotStrategyBlockingMove(testCase)
            % Test bot strategy - blocking move detection
            g = TicTacToe;
            % Set up board where player 2 needs to block player 1
            g.board = [1 1 0; 0 0 0; 0 0 0];
            % It's player 2's turn (even number of pieces)
            testCase.verifyEqual(g.whoseMove, 2)
            
            botMoves(g, 100)
            % Bot should block by playing position 3
            testCase.verifyEqual(g.board(3), 2)
        end
        
        function testDifferentGameTypes(testCase)
            % Test that botMoves works with all game types
            
            % ConnectFour
            g_cf = ConnectFour;
            botMoves(g_cf, 50)
            testCase.verifyEqual(nnz(g_cf.board), 1)
            
            % Reversi
            g_rev = Reversi;
            initialCount = nnz(g_rev.board);
            botMoves(g_rev, 50)
            testCase.verifyGreaterThan(nnz(g_rev.board), initialCount)
            
            % Oxo
            g_oxo = Oxo;
            botMoves(g_oxo, 50)
            testCase.verifyEqual(nnz(g_oxo.board), 1)
        end
        
        function testBotMovePerformance(testCase)
            % Test bot move timing performance
            g = ConnectFour;
            tic
            botMoves(g, 100)
            time100 = toc;
            
            g2 = ConnectFour;
            tic
            botMoves(g2, 1000)
            time1000 = toc;
            
            % More simulations should take more time
            testCase.verifyGreaterThan(time1000, time100)
            % But should still be reasonable (less than 30 seconds)
            testCase.verifyLessThan(time1000, 30)
        end
        
        function testValidMoveSelection(testCase)
            % Test that bot selects valid moves
            g = TicTacToe;
            g.board = [1 0 0; 0 2 0; 0 0 0];
            
            % Get current possible moves
            moves = g.possibleMoves;
            testCase.verifyEqual(length(moves), 7)  % Should have 7 empty positions
            
            % Test that bot selects valid moves
            botMoves(g, 100)
            newMoves = g.possibleMoves;
            testCase.verifyEqual(length(newMoves), 6)  % Should have one fewer move
        end
        
        function testGameAlreadyOver(testCase)
            % Test edge case - game already over
            g = TicTacToe;
            g.board = [1 1 1; 2 2 0; 0 0 0];  % Player 1 already won
            testCase.verifyEqual(g.isGameOver, 1)
            
            % BotMoves should handle gracefully
            originalBoard = g.board;
            botMoves(g, 100)
            % Board should not change
            testCase.verifyEqual(g.board, originalBoard)
        end
    end
end