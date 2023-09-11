import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:ultimate_tic_tac_toe/contollers/iplayer.dart';
import 'package:ultimate_tic_tac_toe/contollers/player_controller.dart';
import 'package:ultimate_tic_tac_toe/game_logic/game_controller.dart';
import 'package:ultimate_tic_tac_toe/game_logic/iplayer.dart';
import 'package:ultimate_tic_tac_toe/game_logic/square.dart';
import 'package:ultimate_tic_tac_toe/game_logic/tile.dart';
import 'package:ultimate_tic_tac_toe/logger.dart';
import 'package:ultimate_tic_tac_toe/models/message.dart';
import 'package:ultimate_tic_tac_toe/models/tile.dart';

part '../gen/contollers/game_controller.g.dart';

class GameController = GameControllerStore with _$GameController;

abstract class GameControllerStore with Store {
  Future<void> startGameLoop() async {
    PlayerContoller firstPlayer = PlayerContoller(figureType: FigureType.cross, playerName: "First Player");
    PlayerContoller secondPlayer = PlayerContoller(figureType: FigureType.circle, playerName: "Second Player");

    _firstPlayer = firstPlayer;
    _secondPlayer = secondPlayer;
    // _currentPlayer = _firstPlayer;

    _gameLogicContoller = GameLogicController(
      firstPlayer: firstPlayer,
      secondPlayer: secondPlayer,
      gameStateUpdate: update,
    );
    _gameLogicContoller.gameLoop();
  }

  IPlayer get firstPlayer => _firstPlayer;
  late IPlayer _firstPlayer;

  IPlayer get secondPlayer => _secondPlayer;
  late IPlayer _secondPlayer;

  @observable
  bool isFirstPlayerMove = true;

  // IPlayer get currentPlayer => _currentPlayer;
  // @observable
  // late IPlayer _currentPlayer;

  late final GameLogicController _gameLogicContoller;

  final StreamController<(int tileId, int squareID)> tapStream =
      StreamController<(int tileId, int squareID)>.broadcast();

  final StreamController<Message> messageStream = StreamController<Message>.broadcast();

  void tileTap(int tileId, int squareId) {
    tapStream.add((tileId, squareId));
  }

  @observable
  int? focusedTile;

  @observable
  ObservableList<TileViewModel> tiles = List.generate(
    9,
    (index) => TileViewModel(
      state: TileState.playing,
      // color: Colors.transparent,
      isForcedTile: false,
      squares: List.generate(9, (index) => SquareState.empty),
    ),
  ).asObservable();

  @action
  void focusNewTile(int? newFocusedTile) {
    focusedTile = newFocusedTile;
  }

  @action
  void update() {
    logger.i("Update");
    List<Tile> loginTiles = _gameLogicContoller.tiles;

    int? forcedMoveTileId = _gameLogicContoller.forceTileMove;

    focusedTile = null;

    for (int i = 0; i < 9; i++) {
      // tiles[i].color = i == forcedMoveTileId ? Colors.amber : Colors.transparent;
      tiles[i].isForcedTile = forcedMoveTileId == i;
      tiles[i].state = loginTiles[i].state;
      tiles[i].squares = loginTiles[i].squares.map((sq) => sq.state).toList();
      // logger.i(tiles[i]);
    }

    // _currentPlayer = (_currentPlayer != _firstPlayer ? _firstPlayer : _secondPlayer);
    isFirstPlayerMove = !isFirstPlayerMove;

    generateMessage();
  }

  void generateMessage() {
    if (_gameLogicContoller.state == GameState.playing) return;

    MessageInfo info = MessageInfo.draw;

    switch (_gameLogicContoller.state) {
      case GameState.playing:
        break;
      case GameState.draw:
        info = MessageInfo.draw;
        break;
      case GameState.circleWin:
        info = MessageInfo.circleWin;
        break;
      case GameState.crossWin:
        info = MessageInfo.crossWin;
        break;
    }
  }
}
