import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:windx1999/get_storage.dart';

class ThemeController extends GetxController {
  final _key = 'isDarkMode';
  final _isDarkMode = false.obs; // Using RxBool for reactive state

  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    // Load theme from storage when controller is initialized
    _isDarkMode.value = StorageUtil.getData(_key) ?? false;

    // Apply the theme to the app
    _updateAppTheme();
  }

  Future<bool> themeMode(bool theme) async {
    _isDarkMode.value = theme;
    // Save theme to storage
    await StorageUtil.saveData(_key, theme);
    // Update the app's theme
    _updateAppTheme();
    return _isDarkMode.value;
  }

  void _updateAppTheme() {
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
