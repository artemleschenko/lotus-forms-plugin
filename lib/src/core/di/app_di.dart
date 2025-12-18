import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:lotus_forms_package/src/data/data.dart';
import 'package:lotus_forms_package/src/data/providers/database/database_impl.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:lotus_forms_package/src/core/network/network_info.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../core.dart';

final GetIt _packageLocator = GetIt.asNewInstance();

class AppDI {
  static bool _isInitialized = false;

  static void init({required String token}) {
    if (_isInitialized) {
      return;
    }

    if (!kIsWeb) {
      _packageLocator.registerLazySingleton<Database>(
        () => DatabaseImpl(
          dbName: ApiConstants.databaseName,
          inMemory: false,
          logStatements: true,
        ),
      );
    }

    _packageLocator
      ..registerLazySingleton(() => TalkerFlutter.init())
      ..registerLazySingleton(
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
      )
      ..registerLazySingleton(
        () => ApiFormProvider(dio: _packageLocator<Dio>()),
      )
      ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl())
      ..registerLazySingleton<FormRepository>(
        () => kIsWeb
            ? WebFormRepositoryImpl(
                formProvider: _packageLocator<ApiFormProvider>(),
              )
            : MobileFormRepositoryImpl(
                formProvider: _packageLocator<ApiFormProvider>(),
                database: _packageLocator<Database>(),
                networkInfo: _packageLocator<NetworkInfo>(),
              ),
      )
      ..registerLazySingleton<OfflineRepository>(
        () => OfflineRepositoryImpl(_packageLocator.get<Database>()),
      )
      // Usecase region
      ..registerLazySingleton(
        () => GetFormUseCase(_packageLocator<FormRepository>()),
      )
      ..registerLazySingleton(
        () => SaveFormUseCase(_packageLocator<FormRepository>()),
      )
      ..registerFactory<SynchronizeUseCase>(
        () => SynchronizeUseCase(
          offlineRepo: _packageLocator.get<OfflineRepository>(),
          remoteRepo: _packageLocator.get<FormRepository>(),
        ),
      );
    // endregion

    _isInitialized = true;
  }

  static T getInstance<T extends Object>() => _packageLocator<T>();
}
