import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lotus_forms_package/src/data/data.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../data/providers/providers.dart';
import '../../domain/domain.dart';
import '../core.dart';

final GetIt _packageLocator = GetIt.asNewInstance();

class AppDI {
  static bool _isInitialized = false;

  static void init({required String token}) {
    if (_isInitialized) {
      return;
    }

    _packageLocator.registerLazySingleton(() => TalkerFlutter.init());

    _packageLocator.registerLazySingleton(
      () => Dio()
        ..options.headers['Authorization'] = 'Bearer $token'
        ..options.baseUrl = ApiConstants.devBaseUrl
        ..interceptors.add(
          TalkerDioLogger(
            talker: _packageLocator(),
            settings: const TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printResponseHeaders: true,
              printResponseMessage: true,
            ),
          ),
        ),
    );

    _packageLocator.registerLazySingleton(
      () => ApiFormProvider(dio: _packageLocator()),
    );

    _packageLocator.registerLazySingleton(
      () => WebFormRepositoryImpl(
        formProvider: _packageLocator<ApiFormProvider>(),
      ),
    );

    // Usecase region
    _packageLocator.registerLazySingleton(
      () => GetFormUseCase(_packageLocator<WebFormRepositoryImpl>()),
    );

    _packageLocator.registerLazySingleton(
      () => SaveFormUseCase(_packageLocator<WebFormRepositoryImpl>()),
    );
    // endregion

    _isInitialized = true;
  }

  static T getInstance<T extends Object>() => _packageLocator<T>();
}
