import 'package:lotus_forms_package/src/data/data.dart';

abstract interface class FormProvider {
  Future<List<FormEntity>> getForms();
  Future<FormEntity> getForm(String formId);
  Future<void> saveForm(FormEntity form);
}
