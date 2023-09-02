import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:ultimate_tic_tac_toe/contollers/game.dart';
import 'package:ultimate_tic_tac_toe/pages/game/game.dart';

void main() {
  setUpSystemUIOverlay();

  GetIt.I.registerSingleton<GameController>(GameController());

  runApp(const App());
}

void setUpSystemUIOverlay() {
  WidgetsFlutterBinding.ensureInitialized();

  // Setting SysemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent));
  // Setting SystmeUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.blue, brightness: Brightness.light),
      darkTheme: ThemeData(colorSchemeSeed: Colors.blueGrey, brightness: Brightness.dark),
      home: GamePage(),
    );
  }
}
