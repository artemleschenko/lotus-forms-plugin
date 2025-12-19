import 'package:lotus_forms_package/src/domain/domain.dart';

abstract interface class FormRepository {
  Future<List<FormModel>> getForms();
  Future<FormModel> getForm(String formId);
  Future<void> saveForm(FormModel form);
}
