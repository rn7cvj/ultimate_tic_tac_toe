// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../contollers/game_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GameController on GameControllerStore, Store {
  late final _$isFirstPlayerMoveAtom =
      Atom(name: 'GameControllerStore.isFirstPlayerMove', context: context);

  @override
  bool get isFirstPlayerMove {
    _$isFirstPlayerMoveAtom.reportRead();
    return super.isFirstPlayerMove;
  }

  @override
  set isFirstPlayerMove(bool value) {
    _$isFirstPlayerMoveAtom.reportWrite(value, super.isFirstPlayerMove, () {
      super.isFirstPlayerMove = value;
    });
  }

  late final _$focusedTileAtom =
      Atom(name: 'GameControllerStore.focusedTile', context: context);

  @override
  int? get focusedTile {
    _$focusedTileAtom.reportRead();
    return super.focusedTile;
  }

  @override
  set focusedTile(int? value) {
    _$focusedTileAtom.reportWrite(value, super.focusedTile, () {
      super.focusedTile = value;
    });
  }

  late final _$tilesAtom =
      Atom(name: 'GameControllerStore.tiles', context: context);

  @override
  ObservableList<TileViewModel> get tiles {
    _$tilesAtom.reportRead();
    return super.tiles;
  }

  @override
  set tiles(ObservableList<TileViewModel> value) {
    _$tilesAtom.reportWrite(value, super.tiles, () {
      super.tiles = value;
    });
  }

  late final _$GameControllerStoreActionController =
      ActionController(name: 'GameControllerStore', context: context);

  @override
  void focusNewTile(int? newFocusedTile) {
    final _$actionInfo = _$GameControllerStoreActionController.startAction(
        name: 'GameControllerStore.focusNewTile');
    try {
      return super.focusNewTile(newFocusedTile);
    } finally {
      _$GameControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update() {
    final _$actionInfo = _$GameControllerStoreActionController.startAction(
        name: 'GameControllerStore.update');
    try {
      return super.update();
    } finally {
      _$GameControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFirstPlayerMove: ${isFirstPlayerMove},
focusedTile: ${focusedTile},
tiles: ${tiles}
    ''';
  }
}
