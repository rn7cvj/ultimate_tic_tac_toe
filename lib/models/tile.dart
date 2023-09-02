import 'package:mobx/mobx.dart';

part 'tile.g.dart';

class Tile = TileStore with _$Tile;

abstract class TileStore with Store {
  @observable
  TileState state = TileState.played;

  @action
  bool setSquareState(int squareIndex, SquareState newState) {
    if (squares[squareIndex] != SquareState.empty) return false;

    squares[squareIndex] = newState;

    List<Set<SquareState>> lineStates = [];

    lineStates.add({squares[0], squares[1], squares[2]});
    lineStates.add({squares[3], squares[4], squares[5]});
    lineStates.add({squares[6], squares[7], squares[8]});

    lineStates.add({squares[0], squares[3], squares[6]});
    lineStates.add({squares[1], squares[4], squares[7]});
    lineStates.add({squares[2], squares[5], squares[8]});

    lineStates.add({squares[0], squares[4], squares[8]});
    lineStates.add({squares[6], squares[4], squares[2]});

    int nonEmptyLines = 0;

    for (Set<SquareState> lineState in lineStates) {
      nonEmptyLines += !lineState.contains(SquareState.empty) ? 1 : 0;
      if (lineState.length == 1 && lineState.first != SquareState.empty) {
        state = (lineState.first == SquareState.circle ? TileState.circleWin : TileState.crossWin);
        return true;
      }
    }

    if (nonEmptyLines == 8) {
      state = TileState.draw;
    }

    return true;
  }

  @observable
  ObservableList<SquareState> squares = [
    SquareState.empty,
    SquareState.empty,
    SquareState.empty,
    SquareState.empty,
    SquareState.empty,
    SquareState.empty,
    SquareState.empty,
    SquareState.empty,
    SquareState.empty,
  ].asObservable();
}

enum TileState {
  played,
  circleWin,
  crossWin,
  draw,
}

enum SquareState {
  empty,
  circle,
  cross,
}
