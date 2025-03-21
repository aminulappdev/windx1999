import 'package:get/get.dart';

class ThemeController extends GetxController {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  Future<bool> themeMode(bool theme) async {
    _isDarkMode = theme;

    update();
    return _isDarkMode;
  }
}
