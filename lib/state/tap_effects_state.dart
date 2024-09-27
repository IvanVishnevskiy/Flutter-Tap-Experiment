import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TapEffect {
  final Offset startPosition;
  final int pointsGained;
  final String id;

  TapEffect(
      {required this.startPosition,
      required this.pointsGained,
      required this.id});
}

class TapEffectsProvider with ChangeNotifier {
  final List<TapEffect> _tapEffects = [];

  List<TapEffect> get tapEffects => _tapEffects;

  void addTap(Offset tapPosition, int pointsPerTap) {
    final tapEffect = TapEffect(
      startPosition: tapPosition,
      pointsGained: pointsPerTap,
      id: const Uuid().v4(),
    );
    _tapEffects.add(tapEffect);
    notifyListeners();
    Future.delayed(const Duration(seconds: 1)).then((_) {
      _tapEffects.remove(tapEffect);
      notifyListeners();
    });
  }
}
