abstract interface class IPlayerLogic {
  Future<Move> getNextMove();
}

class Move {
  final int tileId;
  final int squareId;
  final MoveType moveType;

  final FigureType figureType;

  Move({
    required this.tileId,
    required this.squareId,
    required this.moveType,
    required this.figureType,
  });
}

enum FigureType {
  cross,
  circle,
}

enum MoveType {
  place,
}
