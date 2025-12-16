import 'package:lotus_forms_package/src/domain/domain.dart';

class SynchronizeUseCase {
  final OfflineRepository _offlineRepo;
  final FormRepository _remoteRepo;

  SynchronizeUseCase({
    required OfflineRepository offlineRepo,
    required FormRepository remoteRepo,
  }) : _offlineRepo = offlineRepo,
       _remoteRepo = remoteRepo;

  Stream<bool> watchPendingStatus() {
    return _offlineRepo.hasForms();
  }

  Future<void> executeSync() async {
    final List<FormModel> pendingForms = await _offlineRepo.getForms();

    if (pendingForms.isEmpty) {
      return;
    }

    for (final form in pendingForms) {
      try {
        await _remoteRepo.saveForm(form);

        await _offlineRepo.deleteForm(form.id);
      } catch (e) {
        rethrow;
      }
    }
  }
}
