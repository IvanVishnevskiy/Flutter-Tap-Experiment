import 'package:cocoflutter/components/shared/colored_text.dart';
import 'package:cocoflutter/components/tap_area.dart';
import 'package:cocoflutter/components/tap_effects/tap_effects.dart';
import 'package:cocoflutter/state/game_state.dart';
import 'package:cocoflutter/state/tap_effects_state.dart';
import 'package:cocoflutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tap Game',
        theme: AppTheme.darkTheme,
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => GameStateProvider()),
            ChangeNotifierProvider(create: (context) => TapEffectsProvider()),
          ],
          child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Scaffold(body: Center(child: GameScreen()))),
        ));
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameStateProvider = Provider.of<GameStateProvider>(context);

    return Stack(children: <Widget>[
      Column(
        children: [
          ColoredText('Energy: ${gameStateProvider.gameState.energy}'),
          ColoredText('Points: ${gameStateProvider.gameState.pointCount}'),
          ColoredText('Taps: ${gameStateProvider.gameState.tapCount}'),
          const Expanded(child: TapArea()),
        ],
      ),
      const TapEffects(),
    ]);
  }
}
