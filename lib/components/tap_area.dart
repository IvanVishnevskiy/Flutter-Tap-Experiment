import 'package:cocoflutter/state/tap_effects_state.dart';
import 'package:cocoflutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cocoflutter/state/game_state.dart';

const String heroName = 'media/coco/coco-pink-swag.svg';

const ringDiameter = 300.0;
const ringWidth = 5.0;

class TapArea extends StatefulWidget {
  const TapArea({super.key});

  @override
  State<TapArea> createState() => _TapAreaState();
}

class _TapAreaState extends State<TapArea> with SingleTickerProviderStateMixin {
  double _innerScale = 1.0;
  double _outerScale = 1.0;
  final _ringWidth = ringWidth;
  final _innerRingDiameter = ringDiameter;
  final _outerRingDiameter = ringDiameter + ringWidth;
  final _heroSize = ringDiameter;

  @override
  Widget build(BuildContext context) {
    // Accessing the GameStateProvider from context
    final gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: false);
    final tapEffectsProvider =
        Provider.of<TapEffectsProvider>(context, listen: false);

    return Listener(
        onPointerDown: (event) {
          if (gameStateProvider.currentState.energy >=
              gameStateProvider.currentState.pointsPerTap) {
            _expandRing();
            tapEffectsProvider.addTap(
                event.position, gameStateProvider.currentState.pointsPerTap);
            gameStateProvider
                .dispatch(GameAction(GameActionType.tapsRegisterTap, null));
          }
        },
        onPointerUp: (_) => {_retractRing()},
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: ringDiameter * 1.5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2 < 200
                      ? 200
                      : MediaQuery.of(context).size.height / 2,
                  color:
                      Colors.transparent, // replace with a solid color to debug
                ),
                AnimatedScale(
                  scale: _outerScale,
                  duration:
                      const Duration(milliseconds: 50), // Animation duration
                  curve:
                      Curves.easeInOut, // Animation curve for a smooth effect
                  child: Container(
                    width: _outerRingDiameter +
                        _ringWidth, // Fixed size of the ring
                    height: _outerRingDiameter + _ringWidth,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.tapRing3Color, // Ring color
                    ),
                  ),
                ),
                // The ring behind the SVG, using Transform.scale to expand and retract
                AnimatedScale(
                  scale: _outerScale,
                  duration:
                      const Duration(milliseconds: 50), // Animation duration
                  curve:
                      Curves.easeInOut, // Animation curve for a smooth effect
                  child: Container(
                    width: _outerRingDiameter, // Fixed size of the ring
                    height: _outerRingDiameter,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.tapRing2Color, // Ring color
                    ),
                  ),
                ),
                AnimatedScale(
                  scale: _innerScale,
                  duration:
                      const Duration(milliseconds: 50), // Animation duration
                  curve:
                      Curves.easeInOut, // Animation curve for a smooth effect
                  child: Container(
                    width: _innerRingDiameter, // Fixed size of the ring
                    height: _innerRingDiameter,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.tapRing1Color, // Ring color
                    ),
                  ),
                ),
                Container(
                    width: _innerRingDiameter - _ringWidth,
                    height: _innerRingDiameter - _ringWidth,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppTheme.bodyBg)),
                // The SVG Picture
                Image.asset("media/hero.webp", width: _heroSize),
                // SvgPicture.asset(heroName,
                //     width: _heroSize, semanticsLabel: 'Hero'),
              ],
            )));
  }

  // Method to expand the ring
  void _expandRing() {
    setState(() {
      _innerScale = 1.0 + (_ringWidth / _innerRingDiameter);
      _outerScale = 1.0 + (_ringWidth / _outerRingDiameter) * 2;
    });
  }

  // Method to retract the ring back to its original size
  void _retractRing() {
    setState(() {
      _innerScale = 1.0;
      _outerScale = 1.0;
    });
  }
}
