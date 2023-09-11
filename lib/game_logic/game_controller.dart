import 'package:flutter/material.dart';
import 'package:ultimate_tic_tac_toe/game_logic/iplayer.dart';
import 'package:ultimate_tic_tac_toe/logger.dart';

import 'tile.dart';

class GameLogicController {
  GameLogicController({
    required IPlayerLogic firstPlayer,
    required IPlayerLogic secondPlayer,
    required VoidCallback gameStateUpdate,
  })  : _gameStateUpdate = gameStateUpdate,
        _secondPlayer = secondPlayer,
        _firstPlayer = firstPlayer {
    _currentPlayer = _firstPlayer;
  }

  final IPlayerLogic _firstPlayer;
  final IPlayerLogic _secondPlayer;

  late IPlayerLogic _currentPlayer;

  final VoidCallback _gameStateUpdate;

  GameState get state => _state;
  GameState _state = GameState.playing;

  List<Tile> get tiles => _tiles;
  final List<Tile> _tiles = List.generate(9, (index) => Tile());

  int? _forceTileMove;

  int? get forceTileMove => _forceTileMove;

  Future<void> gameLoop() async {
    logger.i("Game loop start");
    while (state == GameState.playing) {
      Move playerMove = await _currentPlayer.getNextMove();
      bool isMoveValid = _validateMove(playerMove);

      if (isMoveValid) {
        _makeMove(playerMove);
        _switchPlayer();
        _updateGameState();
        _gameStateUpdate();
      }
    }

    logger.i("Game loop end");
  }

  bool _validateMove(Move move) {
    int tileId = move.tileId;

    if (tileId < 0 || tileId > 8) return false;

    if (_forceTileMove != null && tileId != _forceTileMove) return false;

    Tile tile = _tiles[tileId];

    return tile.validateMove(move);
  }

  void _makeMove(Move move) {
    int tileId = move.tileId;
    int squareId = move.squareId;
    Tile tile = _tiles[tileId];
    tile.makeMove(move);

    _forceTileMove = squareId;
  }

  void _switchPlayer() {
    _currentPlayer = _currentPlayer != _firstPlayer ? _firstPlayer : _secondPlayer;
  }

  void _changeState(GameState newState) {
    _state = newState;
  }

  void _updateGameState() {
    for (Tile tile in _tiles) {
      tile.updateTileState();
    }

    List<Set<TileState>> tileStates = [];

    tileStates.add({_tiles[0].state, _tiles[1].state, _tiles[2].state});
    tileStates.add({_tiles[3].state, _tiles[4].state, _tiles[5].state});
    tileStates.add({_tiles[6].state, _tiles[7].state, _tiles[8].state});

    tileStates.add({_tiles[0].state, _tiles[3].state, _tiles[6].state});
    tileStates.add({_tiles[1].state, _tiles[4].state, _tiles[7].state});
    tileStates.add({_tiles[2].state, _tiles[5].state, _tiles[8].state});

    tileStates.add({_tiles[0].state, _tiles[4].state, _tiles[8].state});
    tileStates.add({_tiles[2].state, _tiles[4].state, _tiles[6].state});

    int drawTiles = 0;

    for (Set<TileState> tileState in tileStates) {
      drawTiles += tileState.contains(TileState.draw) ? 1 : 0;

      if (tileState.length == 1 && !tileState.contains(TileState.draw) && !tileState.contains(TileState.playing)) {
        if (tileState.contains(TileState.circleWin)) _changeState(GameState.circleWin);
        if (tileState.contains(TileState.crossWin)) _changeState(GameState.crossWin);

        return;
      }
    }
    if (drawTiles > 6) _changeState(GameState.draw);
  }
}

enum GameState {
  playing,
  draw,
  crossWin,
  circleWin,
}
