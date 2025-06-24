%% Run All Monte Carlo Games Tests
% Master test runner using MATLAB Unit Test framework

% Initialize path
addpath(fullfile(fileparts(pwd), 'toolbox', 'internal'))
initializePath()

fprintf('Running Monte Carlo Games Unit Test Suite...\n')
fprintf('==========================================\n\n')

% Create test suite from all test classes in current directory
import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.TextPlugin

% Create test suite
suite = TestSuite.fromFolder(pwd, 'IncludingSubfolders', false);

% Remove this file from the suite (since it's not a test class)
testClasses = {suite.TestClass};
validTests = ~contains(testClasses, 'RunAllTests');
suite = suite(validTests);

% Create test runner with detailed output
runner = TestRunner.withTextPlugin(TextPlugin.withVerbosity(3));

% Run all tests
results = runner.run(suite);

% Display summary
fprintf('\n==========================================\n')
fprintf('Test Suite Summary:\n')
fprintf('Total Tests: %d\n', length(results))
fprintf('Passed: %d\n', sum([results.Passed]))
fprintf('Failed: %d\n', sum([results.Failed]))
fprintf('Incomplete: %d\n', sum([results.Incomplete]))

if all([results.Passed])
    fprintf('\n✓ ALL TESTS PASSED!\n')
else
    fprintf('\n✗ Some tests failed. See details above.\n')
end

% Alternative simple runner command for quick execution:
% Simply run: runtests('tests') from the project root directory