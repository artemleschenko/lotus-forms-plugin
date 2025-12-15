import 'package:lotus_forms_package/src/domain/models/form.dart';

abstract interface class OfflineRepository {
  Stream<bool> hasForms();
  Future<List<FormModel>> getForms();
  Future<void> deleteForm(String id);
}
