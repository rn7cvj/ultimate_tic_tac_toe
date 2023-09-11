// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/tile.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TileViewModel on TileStore, Store {
  late final _$stateAtom = Atom(name: 'TileStore.state', context: context);

  @override
  TileState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(TileState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$isForcedTileAtom =
      Atom(name: 'TileStore.isForcedTile', context: context);

  @override
  bool get isForcedTile {
    _$isForcedTileAtom.reportRead();
    return super.isForcedTile;
  }

  @override
  set isForcedTile(bool value) {
    _$isForcedTileAtom.reportWrite(value, super.isForcedTile, () {
      super.isForcedTile = value;
    });
  }

  late final _$squaresAtom = Atom(name: 'TileStore.squares', context: context);

  @override
  List<SquareState> get squares {
    _$squaresAtom.reportRead();
    return super.squares;
  }

  @override
  set squares(List<SquareState> value) {
    _$squaresAtom.reportWrite(value, super.squares, () {
      super.squares = value;
    });
  }

  @override
  String toString() {
    return '''
state: ${state},
isForcedTile: ${isForcedTile},
squares: ${squares}
    ''';
  }
}
