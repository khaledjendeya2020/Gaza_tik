import 'dart:io';

class TicTacToe {
  List<String> board = List.generate(9, (index) => (index + 1).toString());
  String currentPlayer = 'X';

  void displayBoard() {
    print('');
    for (int i = 0; i < 9; i += 3) {
      print('${board[i]} | ${board[i + 1]} | ${board[i + 2]}');
      if (i < 6) print('--+---+--');
    }
    print('');
  }

  bool isValidMove(String input) {
    int? pos = int.tryParse(input);
    if (pos == null || pos < 1 || pos > 9) return false;
    return board[pos - 1] != 'X' && board[pos - 1] != 'O';
  }

  void makeMove(String input) {
    int pos = int.parse(input) - 1;
    board[pos] = currentPlayer;
  }

  bool checkWin() {
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      if (board[condition[0]] == currentPlayer &&
          board[condition[1]] == currentPlayer &&
          board[condition[2]] == currentPlayer) {
        return true;
      }
    }
    return false;
  }

  bool isDraw() {
    return board.every((cell) => cell == 'X' || cell == 'O');
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void resetGame() {
    board = List.generate(9, (index) => (index + 1).toString());
    currentPlayer = 'X';
  }

  void startGame() {
    print('=== Welcome to Tic-Tac-Toe ===');

    while (true) {
      displayBoard();
      stdout.write('Player $currentPlayer, enter your move (1-9): ');
      String? input = stdin.readLineSync();

      if (input == null || !isValidMove(input)) {
        print('Invalid move. Try again.');
        continue;
      }

      makeMove(input);

      if (checkWin()) {
        displayBoard();
        print('🎉 Player $currentPlayer wins!');
        break;
      } else if (isDraw()) {
        displayBoard();
        print('It\'s a draw!');
        break;
      }

      switchPlayer();
    }

    stdout.write('\nDo you want to play again? (y/n): ');
    String? again = stdin.readLineSync();
    if (again?.toLowerCase() == 'y') {
      resetGame();
      startGame();
    } else {
      print('Thanks for playing!');
    }
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.startGame();
}
