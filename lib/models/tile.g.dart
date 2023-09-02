// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Tile on TileStore, Store {
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

  late final _$squaresAtom = Atom(name: 'TileStore.squares', context: context);

  @override
  ObservableList<SquareState> get squares {
    _$squaresAtom.reportRead();
    return super.squares;
  }

  @override
  set squares(ObservableList<SquareState> value) {
    _$squaresAtom.reportWrite(value, super.squares, () {
      super.squares = value;
    });
  }

  late final _$TileStoreActionController =
      ActionController(name: 'TileStore', context: context);

  @override
  bool setSquareState(int squareIndex, SquareState newState) {
    final _$actionInfo = _$TileStoreActionController.startAction(
        name: 'TileStore.setSquareState');
    try {
      return super.setSquareState(squareIndex, newState);
    } finally {
      _$TileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
squares: ${squares}
    ''';
  }
}
