import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:ultimate_tic_tac_toe/constants.dart';
import 'package:ultimate_tic_tac_toe/contollers/game_controller.dart';
import 'package:ultimate_tic_tac_toe/pages/local_game/widgets/field.dart';
import 'package:ultimate_tic_tac_toe/pages/local_game/widgets/option_bar.dart';
import 'package:ultimate_tic_tac_toe/pages/local_game/widgets/player_bar.dart';

class LocalGamePage extends StatelessWidget {
  LocalGamePage({super.key});

  final GameController _contoller = GetIt.I<GameController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_contoller.focusedTile == null) true;
        _contoller.focusNewTile(null);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Second Player Option Bar
              PlayerOptionBar(
                padding: const EdgeInsets.all(padding),
              ),

              Padding(
                padding: const EdgeInsets.only(left: padding, right: padding),
                child: Observer(builder: (_) {
                  String message = !_contoller.isFirstPlayerMove ? "your turn" : "wait your oponent turn";
                  return PlayerBar(player: _contoller.secondPlayer, message: message, quarterTurns: -2);
                }),
              ),

              fieldBuilder(context),

              Padding(
                padding: const EdgeInsets.only(left: padding, right: padding),
                child: Observer(builder: (_) {
                  String message = _contoller.isFirstPlayerMove ? "your turn" : "wait your oponent turn";
                  return PlayerBar(player: _contoller.firstPlayer, message: message, quarterTurns: 0);
                }),
              ),

              //First Player Option Bar
              PlayerOptionBar(
                padding: const EdgeInsets.all(padding),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldBuilder(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          elevation: 2,
          child: LayoutBuilder(
            builder: (context, constrains) {
              return Field(
                width: constrains.maxWidth,
                height: constrains.maxHeight,
              );
            },
          ),
        ),
      ),
    );
  }
}
