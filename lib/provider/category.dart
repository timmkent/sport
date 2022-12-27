import 'package:flutter/foundation.dart';

class Category extends ChangeNotifier {
  var currentCategory = '';
  void setCategory(String category) {
    currentCategory = category;
    notifyListeners();
  }

  static final categories = ['CHEST', 'BACK', 'SHOULDER', 'ARMS', 'LEGS', 'N/A'];
}