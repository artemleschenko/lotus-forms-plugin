import 'package:lotus_forms_package/src/domain/models/form_model.dart';

abstract class OfflineRepository {
  Future<bool> hasForms();
  Future<List<FormModel>> getForms();
  Future<void> insertForm(FormModel form);
}
