import 'package:ultimate_tic_tac_toe/game_logic/iplayer.dart';

abstract interface class IPlayer {
  String get name;

  FigureType get figureType;
}
