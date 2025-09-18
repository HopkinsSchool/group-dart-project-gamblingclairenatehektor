// Import the library for standard input/output
import 'dart:io';

// A function to print the current state of the board
void printGameBoard(List<String> board) {
  print(' ${board[0]} | ${board[1]} | ${board[2]} ');
  print(' --- --- ----');
  print(' ${board[3]} | ${board[4]} | ${board[5]} ');
  print(' --- --- ----');
  print(' ${board[6]} | ${board[7]} | ${board[8]} ');
}

bool playerTurn(String currentPlayer, List<String> board) {
  print("Player $currentPlayer, enter your move (e.g. a1, b2):");
  String? move = stdin.readLineSync();

  if (move == null || !board.contains(move)) {
    print("Invalid move, try again.");
    return false; // move failed
  }

  // Replace with player's symbol
  int index = board.indexOf(move);
  board[index] = currentPlayer;

  printGameBoard(board);
  return true; // move worked
}

//function which checks if there is a winner
bool checkWin(List spots) {
  //get X positions
  Set<int> posX =
      {}; //sets are diff bc order doesnt matter, duplicates dont count, we j want to know if the positions are in the list of wins
  Set<int> posO = {};
  List wins = [
    {0, 1, 2},
    {3, 4, 5},
    {6, 7, 8},
    {0, 3, 6},
    {1, 4, 7},
    {2, 5, 8},
    {0, 4, 8},
    {2, 4, 6},
  ];

  for (int i = 0; i < 9; i++) {
    if (spots[i] == 'X') {
      posX.add(i);
    } else if (spots[i] == 'O') {
      posO.add(i);
    }
  }

  for (Set<int> combo in wins) {
    //for each of the possible win conditions
    if (posX.containsAll(combo) || posO.containsAll(combo)) {
      //if all nums in List wins are included in posX
      return true;
    }
  }
  return false;
}

void main() {

  // The list to represent the game board
  List<String> gameBoard = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3'];

  printGameBoard(gameBoard);
  String currentPlayer = 'X';
  int moves = 0;

  while (true) {
    bool moveMade = playerTurn(currentPlayer, gameBoard);

    if (!moveMade) continue; // ask again if invalid
    moves++;

    if (checkWin(gameBoard)) {
      print("Player $currentPlayer wins!");
      break;
    }

    if (moves == 9) {
      print("It's a draw!");
      break;
    }

    // Switch players
    if (currentPlayer == 'X') {
      currentPlayer = 'O';
    } else {
      currentPlayer = 'X';
    }
  }
}