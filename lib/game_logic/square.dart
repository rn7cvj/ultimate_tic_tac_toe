class Square {
  SquareState state = SquareState.empty;

  void changeState(SquareState newState) {
    state = newState;
  }
}

enum SquareState {
  empty,
  cross,
  circle,
}
