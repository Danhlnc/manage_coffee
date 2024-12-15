import 'package:flutter/foundation.dart';

class TimerInfo extends ChangeNotifier {
  int _remainingTime = 1;

  int getRemainingTime() => _remainingTime;

  updateRemainingTime() {
    _remainingTime--;
    notifyListeners();
  }
}
