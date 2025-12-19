import 'package:lotus_forms_package/src/domain/domain.dart';

class SynchronizeController {
  final SynchronizeUseCase _useCase;

  SynchronizeController({required SynchronizeUseCase useCase})
    : _useCase = useCase;

  Future<void> sync() {
    return _useCase.executeSync();
  }

  Stream<bool> hasData() {
    return _useCase.watchPendingStatus();
  }
}
