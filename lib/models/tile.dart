import 'dart:ui';

import 'package:mobx/mobx.dart';
import 'package:ultimate_tic_tac_toe/game_logic/square.dart';
import 'package:ultimate_tic_tac_toe/game_logic/tile.dart';

part '../gen/models/tile.g.dart';

class TileViewModel = TileStore with _$TileViewModel;

abstract class TileStore with Store {
  TileStore({
    required this.state,
    required this.isForcedTile,
    required this.squares,
  });

  @observable
  TileState state;

  @observable
  bool isForcedTile;

  @observable
  List<SquareState> squares;
}
