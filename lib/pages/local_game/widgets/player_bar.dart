import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultimate_tic_tac_toe/constants.dart';
import 'package:ultimate_tic_tac_toe/contollers/iplayer.dart';
import 'package:ultimate_tic_tac_toe/game_logic/iplayer.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({super.key, required this.player, required this.quarterTurns, required this.message});

  final IPlayer player;
  final int quarterTurns;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: RotatedBox(
            quarterTurns: quarterTurns,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  player.figureType == FigureType.circle ? "assets/circle.svg" : "assets/cross.svg",
                  height: 25,
                  width: 25,
                  // color: Theme.of(context).colorScheme.secondary,
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
                ),
                Text("${player.name}, $message"),
                const SizedBox(
                  height: 25,
                  width: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
