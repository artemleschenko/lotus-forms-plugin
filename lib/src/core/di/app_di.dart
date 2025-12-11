import 'package:get_it/get_it.dart';

final GetIt appLocator = GetIt.instance;

class AppDI {
  static bool _isInitialized = false;
  static void init() {
    if (_isInitialized) return;

    _isInitialized = true;
  }
}
