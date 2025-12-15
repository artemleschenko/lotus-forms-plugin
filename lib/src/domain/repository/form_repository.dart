import 'package:lotus_forms_package/src/domain/domain.dart';

import 'package:lotus_forms_package/src/domain/entities/form.dart';

abstract interface class FormRepository {
  Future<List<FormEntity>> getForms();
  Future<FormEntity> getForm(String formId);
  Future<void> saveForm(FormEntity form);
}
