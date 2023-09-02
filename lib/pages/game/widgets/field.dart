import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:ultimate_tic_tac_toe/constants.dart';
// import 'package:ultimate_tic_tac_toe/models/tile.dart';
import 'package:ultimate_tic_tac_toe/pages/game/tile.dart';

import '../../../contollers/game.dart';
import '../../../models/tile.dart';
import 'tic_tac_toe_field.dart';

List<Color> colors = [
  Colors.amber,
  Colors.blue,
  Colors.green,
  Colors.pink,
  Colors.brown,
  Colors.cyan,
  Colors.orange,
  Colors.indigo,
  Colors.purple
];

class Field extends StatelessWidget {
  Field({super.key, required this.width, required this.height});

  final GameController controller = GetIt.I<GameController>();

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => Observer(
        builder: (context) {
          List<TileViewModel> tiles = buildTiles(controller.focusedTile);
          bool canZoom = controller.focusedTile == null;
          return Stack(
            children: tiles.map(
              (tileData) {
                int index = tiles.indexOf(tileData);

                Color tileColor = Colors.transparent;

                if (controller.forceMoveTile == index) {
                  tileColor = Theme.of(context).colorScheme.onPrimary.withOpacity(0.4);
                }

                return AnimatedPositioned(
                  top: tileData.dy,
                  left: tileData.dx,
                  width: tileData.widht,
                  height: tileData.height,
                  duration: zoomAnimationDuration,
                  child: InkWell(
                    onTap: (canZoom ? () => controller.focusNewTile(index) : null),
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: tileColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildTileContent(controller.tiles[index].state, index, tileData.widht, tileData.height),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        },
      );

  List<TileViewModel> buildTiles(int? focusedTile) {
    if (focusedTile == null) return unzoomTiles();
    return zoomTiles(focusedTile % 3, focusedTile ~/ 3);
  }

  List<TileViewModel> zoomTiles(int x, int y) {
    double tileSize = min(width, height);

    double orginalTileSize = tileSize;

    tileSize *= 0.9;

    List<TileViewModel> newTiles = [];
    for (int i = 0; i < 9; i++) {
      int tx = i % 3;
      int ty = i ~/ 3;

      int dx = tx - x;
      int dy = ty - y;

      newTiles.add(TileViewModel(
        color: colors[i],
        widht: tileSize,
        height: tileSize,
        dx: tileSize * dx + (orginalTileSize - tileSize) / 2,
        dy: tileSize * dy + (orginalTileSize - tileSize) / 2,
      ));
    }

    return newTiles;
  }

  List<TileViewModel> unzoomTiles() {
    double tileSize = min(width, height) / 3;

    List<TileViewModel> newTiles = [];
    for (int i = 0; i < 9; i++) {
      newTiles.add(TileViewModel(
        color: colors[i],
        widht: tileSize,
        height: tileSize,
        dx: tileSize * (i % 3),
        dy: tileSize * (i ~/ 3),
      ));
    }

    return newTiles;
  }

  Widget buildTileContent(TileState state, int tileId, double tileWidth, double tileHeight) {
    switch (state) {
      case TileState.played:
        return TicTacToeField(tileId: tileId);

      case TileState.crossWin:
        return SvgPicture.asset("assets/cross.svg", width: tileWidth, height: tileHeight);

      case TileState.circleWin:
        return SvgPicture.asset("assets/circle.svg", width: tileWidth, height: tileHeight);
      case TileState.draw:
        return SvgPicture.asset("assets/draw.svg", width: tileWidth, height: tileHeight);
    }
  }
}
