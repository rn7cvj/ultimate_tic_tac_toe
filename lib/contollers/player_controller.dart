import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ultimate_tic_tac_toe/contollers/iplayer.dart';
import 'package:ultimate_tic_tac_toe/contollers/game_controller.dart';
import 'package:ultimate_tic_tac_toe/game_logic/iplayer.dart';

typedef PlayerTapCallback = (int tileId, int squareId) Function();

class PlayerContoller implements IPlayerLogic, IPlayer {
  final String playerName;

  final FigureType _figureType;

  final GameController _controller = GetIt.I<GameController>();

  PlayerContoller({required FigureType figureType, required this.playerName}) : _figureType = figureType;

  @override
  Future<Move> getNextMove() async {
    // (tileId) move = await Future.delayed(Duration(milliseconds: 400));
    var (tileId, squareId) = await _controller.tapStream.stream.first;

    return Future.value(Move(
      tileId: tileId,
      squareId: squareId,
      figureType: _figureType,
      moveType: MoveType.place,
    ));
  }

  @override
  String get name => playerName;

  @override
  FigureType get figureType => _figureType;
}
