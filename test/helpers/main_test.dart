import 'package:lotus_forms_package/src/data/data.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';
import 'package:lotus_forms_package/src/core/network/network_info.dart';
import 'package:mockito/annotations.dart';

// Generate mocks for these classes
@GenerateMocks([
  FormProvider,
  Database,
  FormRepository,
  OfflineRepository,
  SynchronizeUseCase,
  NetworkInfo,
])
void main() {
  // This file is used only for mock generation
  // Run: flutter pub run build_runner build
}
