import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ultimate_tic_tac_toe/constants.dart';
import 'package:ultimate_tic_tac_toe/contollers/game_controller.dart';

class PlayerOptionBar extends StatelessWidget {
  PlayerOptionBar({super.key, required this.padding});
  final GameController _contoller = GetIt.I<GameController>();

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: padding,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () => _contoller.focusNewTile(null),
        ),
      ),
    );
  }
}
