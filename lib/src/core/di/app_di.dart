import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt appLocator = GetIt.instance;

class AppDI {
  static bool _isInitialized = false;
  static void init({required String token}) {
    if (_isInitialized) return;
    appLocator.registerSingleton(Dio());
    _isInitialized = true;
  }
}
