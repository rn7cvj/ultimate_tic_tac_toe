import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:ultimate_tic_tac_toe/constants.dart';
import 'package:ultimate_tic_tac_toe/models/message.dart';

import '../models/tile.dart';

part 'game.g.dart';

class GameController = GameContollerStore with _$GameController;

abstract class GameContollerStore with Store {
  StreamController<Message> messageStream = StreamController<Message>();

  @action
  void focusNewTile(int? newFocusedTIle) {
    if (_canFocusedNewTile) focusedTile = newFocusedTIle;
  }

  @observable
  SquareState currentPlayerState = SquareState.circle;

  @action
  void setSquareState(int tileIndex, int squareIndex) {
    if (tileIndex != forceMoveTile && forceMoveTile != null) {
      return;
    }

    if (!tiles[tileIndex].setSquareState(squareIndex, currentPlayerState)) {
      messageStream.add(
        Message(
          type: MessageType.warning,
          reciver:
              (currentPlayerState == SquareState.circle ? MessageReciver.FirstPlayer : MessageReciver.SecondPlayer),
          info: MessageInfo.IllegalMove,
        ),
      );
      return;
    }

    currentPlayerState = (currentPlayerState == SquareState.circle ? SquareState.cross : SquareState.circle);

    forceMoveTile = squareIndex;

    if (tiles[squareIndex].state != TileState.played) {
      messageStream.add(
        Message(
          type: MessageType.info,
          reciver:
              (currentPlayerState == SquareState.circle ? MessageReciver.FirstPlayer : MessageReciver.SecondPlayer),
          info: MessageInfo.NoForceTile,
        ),
      );
      forceMoveTile = null;
    }

    focusedTile = null;

    // if (focusedTile != squareIndex) {
    //   _canFocusedNewTile = false;
    //   focusedTile = null;

    //   Future.delayed(zoomAnimationDuration, () {
    //     runInAction(() => focusedTile = squareIndex);
    //     _canFocusedNewTile = true;
    //   });
    // }
  }

  bool _canFocusedNewTile = true;

  @observable
  int? focusedTile;

  @observable
  int? forceMoveTile;

  @observable
  ObservableList<Tile> tiles = [
    Tile(),
    Tile(),
    Tile(),
    Tile(),
    Tile(),
    Tile(),
    Tile(),
    Tile(),
    Tile(),
  ].asObservable();
}
