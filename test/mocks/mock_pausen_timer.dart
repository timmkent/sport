import 'package:flutter/material.dart';
import 'package:flutter_sport/provider/pausen_timer.dart';

class MockPausenTimer extends ChangeNotifier implements BasePausenTimer {
  @override
  int remainingSeconds = 0;

  bool startCountdownWasCalled = false;
  @override
  void startCountdown(int seconds) {
    startCountdownWasCalled = true;
  }
}
