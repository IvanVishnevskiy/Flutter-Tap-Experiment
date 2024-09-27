import 'package:cocoflutter/components/tap_effects/tap_effect.dart';
import 'package:cocoflutter/state/tap_effects_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TapEffects extends StatelessWidget {
  const TapEffects({super.key});

  @override
  Widget build(BuildContext context) {
    final tapEffectsProvider = Provider.of<TapEffectsProvider>(context);
    return Stack(
      children: [
        for (final tapEffect in tapEffectsProvider.tapEffects)
          AnimatedText(
            key: ValueKey(tapEffect.id),
            startPosition: tapEffect.startPosition,
            pointsGained: tapEffect.pointsGained,
          )
      ],
    );
  }
}
