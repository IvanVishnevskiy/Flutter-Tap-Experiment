import 'dart:async';

import 'package:flutter/material.dart';

const tapEffectsTimeout =
    Duration(seconds: 1); // remove taps from list after this time
const tapEffectsThrottle =
    Duration(milliseconds: 50); // min time before triggering ring animation

// Define GameAction
enum GameActionType {
  tapsApplyPointIncome,
  energyConsume,
  energyRegen,
  dataInitialize,
  tapsSetPointIncome,
  tapsRegisterTap,
}

class GameAction {
  final GameActionType type;
  final dynamic payload;

  GameAction(this.type, [this.payload]);
}

// Define FrontendGameState
class FrontendGameState {
  int maxEnergy;
  int energyRecoveryPerSecond;
  int pointCount;
  int pointIncomePerSecond;
  int pointsPerTap;
  int tapCount;
  String lastGameStateSyncTime;
  int level;
  String levelName;
  int targetExp;
  int currentExp;
  int maxLevel;

  // Frontend specific fields
  int energy;
  int tapCountSynced;
  int tapCountPending;

  FrontendGameState({
    this.maxEnergy = 1000,
    this.energyRecoveryPerSecond = 1,
    this.pointCount = 0,
    this.pointIncomePerSecond = 5,
    this.pointsPerTap = 3,
    this.tapCount = 0,
    this.lastGameStateSyncTime = '',
    this.level = 1,
    this.levelName = 'Beginner',
    this.targetExp = 100,
    this.currentExp = 0,
    this.maxLevel = 50,
    this.energy = 1000,
    this.tapCountSynced = 0,
    this.tapCountPending = 0,
  });
}

class GameStateProvider with ChangeNotifier {
  // The current state of the game.
  FrontendGameState _gameState = FrontendGameState();

  // Timer for the game loop.
  Timer? _timer;

  GameStateProvider() {
    _startGameLoop();
  }

  // Start the game loop.
  void _startGameLoop() {
    // Periodically call the game loop.
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // Regenerate energy.
        dispatch(GameAction(GameActionType.energyRegen));
        // Apply point income.
        dispatch(GameAction(GameActionType.tapsApplyPointIncome));
      },
    );
  }

  FrontendGameState get gameState => _gameState;

  // Dispatch a game action.
  void dispatch(GameAction action) {
    // Handle the action.
    switch (action.type) {
      // Initialize the game state.
      case GameActionType.dataInitialize:
        _gameState = action.payload;
        break;
      // Set the point income per second.
      case GameActionType.tapsSetPointIncome:
        _gameState.pointIncomePerSecond = action.payload;
        break;
      // Apply the point income.
      case GameActionType.tapsApplyPointIncome:
        _gameState.pointCount += _gameState.pointIncomePerSecond;
        break;
      // Register a tap.
      case GameActionType.tapsRegisterTap:
        if (_gameState.energy >= _gameState.pointsPerTap) {
          _gameState.tapCountPending++;
          _gameState.pointCount += _gameState.pointsPerTap;
          _gameState.tapCount++;
          _gameState.energy -= _gameState.pointsPerTap;
          action.payload?.call(true);
        } else {
          // Call the callback (if present) with failure.
          action.payload?.call(false);
        }
        break;
      // Consume energy.
      case GameActionType.energyConsume:
        _gameState.energy = (_gameState.energy - _gameState.pointsPerTap)
            .clamp(0, _gameState.maxEnergy);
        break;
      // Regenerate energy.
      case GameActionType.energyRegen:
        _gameState.energy =
            (_gameState.energy + _gameState.energyRecoveryPerSecond)
                .clamp(0, _gameState.maxEnergy);
        break;
    }
    notifyListeners();
  }

  FrontendGameState get currentState => _gameState;

  // Dispose of the game state provider.
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  String toString() {
    return gameState.toString();
  }
}
