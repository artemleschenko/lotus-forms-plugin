import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lotus_forms_package/src/data/data.dart';
import 'package:lotus_forms_package/src/data/providers/database/database_impl.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';

final GetIt appLocator = GetIt.instance;

class AppDI {
  static bool _isInitialized = false;
  static void init() {
    if (_isInitialized) return;
    //providers
    appLocator
      ..registerSingleton(Dio())
      ..registerLazySingleton<Database>(
        () => DatabaseImpl(
          dbName: 'forms.db',
          inMemory: false,
          logStatements: true,
        ),
      )
      //repositories
      ..registerLazySingleton<OfflineRepository>(
        () => OfflineRepositoryImpl(appLocator.get<Database>()),
      )
      //use cases
      ..registerFactory<SynchronizeUseCase>(
        () => SynchronizeUseCase(
          offlineRepo: appLocator.get<OfflineRepository>(),
          remoteRepo: appLocator.get<FormRepository>(),
        ),
      );
    _isInitialized = true;
  }
}
