import 'package:flutter/material.dart';
import 'themes.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _selectedTheme = availableThemes[0];

  ThemeData get selectedTheme => _selectedTheme;

  set selectedTheme(ThemeData theme) {
    _selectedTheme = theme;
    notifyListeners();
  }
}
