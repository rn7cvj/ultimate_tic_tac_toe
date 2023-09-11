import 'package:ultimate_tic_tac_toe/game_logic/iplayer.dart';
import 'package:ultimate_tic_tac_toe/game_logic/square.dart';

class Tile {
  TileState state = TileState.playing;

  List<Square> squares = List.generate(9, (index) => Square());

  bool validateMove(Move move) {
    int squareId = move.squareId;

    if (squareId < 0 || squareId > 8) return false;

    Square square = squares[squareId];

    return square.state == SquareState.empty;
  }

  void makeMove(Move move) {
    int squareId = move.squareId;
    squares[squareId].changeState(move.figureType == FigureType.circle ? SquareState.circle : SquareState.cross);
  }

  void updateTileState() {
    List<Set<SquareState>> squareStates = [];

    squareStates.add({squares[0].state, squares[1].state, squares[2].state});
    squareStates.add({squares[3].state, squares[4].state, squares[5].state});
    squareStates.add({squares[6].state, squares[7].state, squares[8].state});

    squareStates.add({squares[0].state, squares[3].state, squares[6].state});
    squareStates.add({squares[1].state, squares[4].state, squares[7].state});
    squareStates.add({squares[2].state, squares[5].state, squares[8].state});

    squareStates.add({squares[0].state, squares[4].state, squares[8].state});
    squareStates.add({squares[3].state, squares[4].state, squares[6].state});

    int nonEmptyLines = 0;

    for (Set<SquareState> squareState in squareStates) {
      nonEmptyLines += !squareState.contains(SquareState.empty) ? 1 : 0;

      if (squareState.length == 1 && !squareState.contains(SquareState.empty)) {
        if (squareState.contains(SquareState.circle)) changeState(TileState.circleWin);
        if (squareState.contains(SquareState.cross)) changeState(TileState.crossWin);

        return;
      }
    }
    if (nonEmptyLines == 8) changeState(TileState.draw);
  }

  void changeState(TileState newState) {
    state = newState;
  }
}

enum TileState {
  playing,
  draw,
  crossWin,
  circleWin,
}
