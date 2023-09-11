import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ultimate_tic_tac_toe/logger.dart';
import 'package:ultimate_tic_tac_toe/constants.dart';
import 'package:ultimate_tic_tac_toe/models/tile.dart';
import 'package:ultimate_tic_tac_toe/game_logic/tile.dart';
import 'package:ultimate_tic_tac_toe/contollers/game_controller.dart';
import 'package:ultimate_tic_tac_toe/pages/local_game/widgets/field_tile.dart';

class Field extends StatelessWidget {
  Field({super.key, required double width, required double height})
      : _width = width,
        _height = height;

  final GameController _contoller = GetIt.I<GameController>();
  final double _width;
  final double _height;

  @override
  Widget build(BuildContext context) => Observer(
        builder: (BuildContext context) {
          int? focusedTileId = _contoller.focusedTile;
          bool canZoom = focusedTileId == null;

          List<dynamic> tiles = buildTiles(focusedTileId);

          return Stack(
            children: tiles.map(
              (tileData) {
                int tileId = tileData["tileId"];
                // Color color = tileData["color"];
                bool isForcedTile = tileData["isForcedTile"];

                Color color =
                    isForcedTile ? Theme.of(context).colorScheme.secondary.withOpacity(0.4) : Colors.transparent;

                double topDelta = tileData["topDelta"];
                double leftDelta = tileData["leftDelta"];
                double width = tileData["width"];
                double height = tileData["height"];

                return AnimatedPositioned(
                  top: topDelta,
                  left: leftDelta,
                  width: width,
                  height: height,
                  duration: zoomAnimationDuration,
                  child: InkWell(
                    onTap: (canZoom ? () => _contoller.focusNewTile(tileId) : null),
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(padding),
                        child: buildTile(context, _contoller.tiles[tileId].state, tileId, width, height),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        },
      );

  Widget buildTile(BuildContext context, TileState state, int tileId, double tileWidth, double tileHeight) {
    switch (state) {
      case TileState.playing:
        return FiledTile(
          tileId: tileId,
        );
      case TileState.draw:
        return SvgPicture.asset(
          "assets/draw.svg",
          width: tileWidth,
          height: tileHeight,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
        );
      case TileState.circleWin:
        return SvgPicture.asset(
          "assets/circle.svg",
          width: tileWidth,
          height: tileHeight,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
        );
      case TileState.crossWin:
        return SvgPicture.asset(
          "assets/cross.svg",
          width: tileWidth,
          height: tileHeight,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
        );
    }
  }

  List<dynamic> buildTiles(int? focusedTileId) =>
      (focusedTileId == null ? unzoomTiles() : zoomTiles(focusedTileId)).toList();

  Iterable<dynamic> unzoomTiles() sync* {
    double tileSize = min(_width, _height) / 3;

    List<TileViewModel> tiles = _contoller.tiles;

    for (int i = 0; i < 9; i++) {
      yield {
        "tileId": i,
        // "color": tiles[i].color,
        "isForcedTile": tiles[i].isForcedTile,
        "topDelta": tileSize * (i ~/ 3),
        "leftDelta": tileSize * (i % 3),
        "width": tileSize,
        "height": tileSize,
      };
    }
  }

  Iterable<dynamic> zoomTiles(int zoomTileId) sync* {
    double tileSize = min(_width, _height);

    double orginalTileSize = tileSize;

    tileSize *= 0.9;

    int zoomTileX = zoomTileId % 3;
    int zoomTileY = zoomTileId ~/ 3;

    List<TileViewModel> tiles = _contoller.tiles;

    for (int i = 0; i < 9; i++) {
      int tx = i % 3;
      int ty = i ~/ 3;

      int dx = tx - zoomTileX;
      int dy = ty - zoomTileY;

      yield {
        "tileId": i,
        // "color": tiles[i].color,
        "isForcedTile": tiles[i].isForcedTile,
        "topDelta": tileSize * dy + (orginalTileSize - tileSize) / 2,
        "leftDelta": tileSize * dx + (orginalTileSize - tileSize) / 2,
        "width": tileSize,
        "height": tileSize,
      };
    }
  }
}
