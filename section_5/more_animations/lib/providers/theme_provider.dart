import 'package:flutter/widgets.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get darkMode => _isDarkMode;

  void changeDarkModeSetting() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
