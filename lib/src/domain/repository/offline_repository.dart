import 'package:lotus_forms_package/src/domain/models/form_model.dart';

abstract interface class OfflineRepository {
  Stream<bool> hasForms();
  Future<List<FormModel>> getForms();
  Future<void> deleteForm(int id);
}
