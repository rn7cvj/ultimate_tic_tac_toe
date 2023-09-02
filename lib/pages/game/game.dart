import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:ultimate_tic_tac_toe/contollers/game.dart';
import 'package:ultimate_tic_tac_toe/logger.dart';
import 'package:ultimate_tic_tac_toe/models/message.dart';
import 'package:ultimate_tic_tac_toe/models/tile.dart';
import 'package:ultimate_tic_tac_toe/pages/game/widgets/field.dart';
import 'package:ultimate_tic_tac_toe/pages/game/widgets/players_bar.dart';

VoidCallback? outsideTap;

class GamePage extends StatelessWidget {
  GamePage({super.key});

  final GameController controller = GetIt.I<GameController>();

  @override
  Widget build(BuildContext context) {
    controller.messageStream.stream.listen(
      (message) {
        SnackBarPosition snackBarPosition = SnackBarPosition.bottom;

        if (message.reciver == MessageReciver.SecondPlayer) snackBarPosition = SnackBarPosition.top;

        Widget snackBarContent = Material(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(message.info.toString())),
            ),
          ),
        );

        if (message.reciver == MessageReciver.SecondPlayer) {
          snackBarContent = RotatedBox(
            quarterTurns: -2,
            child: snackBarContent,
          );
        }

        showTopSnackBar(
          Overlay.of(context),
          snackBarContent,
          snackBarPosition: snackBarPosition,
          dismissDirection: [DismissDirection.none],
        );
      },
    );

    return WillPopScope(
      onWillPop: () async {
        if (controller.focusedTile == null) true;
        controller.focusNewTile(null);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Tap to unzoom
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () => controller.focusNewTile(null),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),

              // Second players bar
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Observer(
                  builder: (_) {
                    return PlayersBar(
                      title:
                          controller.currentPlayerState == SquareState.cross ? "Your turn" : "Wait your opponent turn",
                      svgPath: "assets/cross.svg",
                      quarterTurns: 2,
                    );
                  },
                ),
              ),

              // Filed
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                    elevation: 2,
                    child: LayoutBuilder(
                      builder: (context, constrains) => AspectRatio(
                        aspectRatio: 1,
                        child: Field(width: constrains.maxWidth, height: constrains.maxHeight),
                      ),
                    ),
                  ),
                ),
              ),

              // First players bar
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Observer(
                  builder: (_) {
                    return PlayersBar(
                      title:
                          controller.currentPlayerState == SquareState.circle ? "Your turn" : "Wait your opponent turn",
                      svgPath: "assets/circle.svg",
                      quarterTurns: 0,
                    );
                  },
                ),
              ),

              // Tap to unzoom
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () => controller.focusNewTile(null),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
