import '../../domain/domain.dart';

abstract interface class FormProvider {
  Future<List<FormEntity>> getForms();
  Future<FormEntity> getForm(String formId);
}
