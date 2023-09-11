import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:ultimate_tic_tac_toe/constants.dart';

import 'package:ultimate_tic_tac_toe/contollers/game_controller.dart';
import 'package:ultimate_tic_tac_toe/game_logic/square.dart';

class FiledTile extends StatelessWidget {
  FiledTile({super.key, required this.tileId});

  final int tileId;
  final GameController _controller = GetIt.I<GameController>();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;

          double tileSize = min(width, height) / 3;

          bool isZoom = _controller.focusedTile != null;

          return GridView.count(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: List.generate(
              9,
              (index) {
                return SizedBox(
                  width: tileSize,
                  height: tileSize,
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                      topLeft: index == 0 ? Radius.circular(borderRadius) : Radius.zero,
                      topRight: index == 2 ? Radius.circular(borderRadius) : Radius.zero,
                      bottomLeft: index == 6 ? Radius.circular(borderRadius) : Radius.zero,
                      bottomRight: index == 8 ? Radius.circular(borderRadius) : Radius.zero,
                    ),
                    onTap: isZoom ? () => _controller.tileTap(tileId, index) : null,
                    child: Observer(
                      builder: (_) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: [0, 3, 6, 1, 4, 7].contains(index)
                                  ? BorderSide(color: Colors.black.withOpacity(0.4))
                                  : BorderSide.none,
                              left: [2, 5, 8, 1, 4, 7].contains(index)
                                  ? BorderSide(color: Colors.black.withOpacity(0.4))
                                  : BorderSide.none,
                              top: (index > 2) ? BorderSide(color: Colors.black.withOpacity(0.4)) : BorderSide.none,
                              bottom: (index < 6) ? BorderSide(color: Colors.black.withOpacity(0.4)) : BorderSide.none,
                            ),
                          ),
                          child: tileContent(
                            context,
                            _controller.tiles[tileId].squares[index],
                            tileSize,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      );

  Widget? tileContent(BuildContext context, SquareState state, double tileSize) {
    switch (state) {
      case SquareState.circle:
        return SvgPicture.asset(
          "assets/circle.svg",
          // colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.tertiary, BlendMode.color),
          // color: Theme.of(context).colorScheme.secondary,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn),

          width: tileSize,
          height: tileSize,
        );
      case SquareState.cross:
        return SvgPicture.asset(
          "assets/cross.svg",
          // colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.tertiary, BlendMode.color),
          // color: Theme.of(context).colorScheme.secondary,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn),

          width: tileSize,
          height: tileSize,
        );
      case SquareState.empty:
        return null;
    }
  }
}
