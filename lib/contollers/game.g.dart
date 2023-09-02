// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GameController on GameContollerStore, Store {
  late final _$currentPlayerStateAtom =
      Atom(name: 'GameContollerStore.currentPlayerState', context: context);

  @override
  SquareState get currentPlayerState {
    _$currentPlayerStateAtom.reportRead();
    return super.currentPlayerState;
  }

  @override
  set currentPlayerState(SquareState value) {
    _$currentPlayerStateAtom.reportWrite(value, super.currentPlayerState, () {
      super.currentPlayerState = value;
    });
  }

  late final _$focusedTileAtom =
      Atom(name: 'GameContollerStore.focusedTile', context: context);

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

  late final _$forceMoveTileAtom =
      Atom(name: 'GameContollerStore.forceMoveTile', context: context);

  @override
  int? get forceMoveTile {
    _$forceMoveTileAtom.reportRead();
    return super.forceMoveTile;
  }

  @override
  set forceMoveTile(int? value) {
    _$forceMoveTileAtom.reportWrite(value, super.forceMoveTile, () {
      super.forceMoveTile = value;
    });
  }

  late final _$tilesAtom =
      Atom(name: 'GameContollerStore.tiles', context: context);

  @override
  ObservableList<Tile> get tiles {
    _$tilesAtom.reportRead();
    return super.tiles;
  }

  @override
  set tiles(ObservableList<Tile> value) {
    _$tilesAtom.reportWrite(value, super.tiles, () {
      super.tiles = value;
    });
  }

  late final _$GameContollerStoreActionController =
      ActionController(name: 'GameContollerStore', context: context);

  @override
  void focusNewTile(int? newFocusedTIle) {
    final _$actionInfo = _$GameContollerStoreActionController.startAction(
        name: 'GameContollerStore.focusNewTile');
    try {
      return super.focusNewTile(newFocusedTIle);
    } finally {
      _$GameContollerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSquareState(int tileIndex, int squareIndex) {
    final _$actionInfo = _$GameContollerStoreActionController.startAction(
        name: 'GameContollerStore.setSquareState');
    try {
      return super.setSquareState(tileIndex, squareIndex);
    } finally {
      _$GameContollerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPlayerState: ${currentPlayerState},
focusedTile: ${focusedTile},
forceMoveTile: ${forceMoveTile},
tiles: ${tiles}
    ''';
  }
}
