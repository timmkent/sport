import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

abstract class BasePausenTimer extends ChangeNotifier {
  void startCountdown(int seconds);
  var remainingSeconds = 0;
}

class PausenTimer extends ChangeNotifier implements BasePausenTimer{
  @override
  var remainingSeconds = 0;
  var endTime = 0;
  @override
  void startCountdown(int seconds) {
    endTime = (DateTime.now().millisecond ~/ 1000) + seconds;
    Timer.periodic(Duration(seconds: seconds), (timer) {
      final nowSeconds = DateTime.now().millisecond ~/ 1000;

      remainingSeconds = max(endTime - nowSeconds, 0);
      notifyListeners();
    });
  }
}