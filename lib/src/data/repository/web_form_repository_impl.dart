import 'package:lotus_forms_package/src/domain/domain.dart';

import '../providers/providers.dart';

class WebFormRepositoryImpl implements FormRepository {
  WebFormRepositoryImpl({required this.formProvider});

  final FormProvider formProvider;

  @override
  Future<List<FormEntity>> getForms() async {
    return formProvider.getForms();
  }

  @override
  Future<FormEntity> getForm(String formId) async {
    return formProvider.getForm(formId);
  }

  @override
  Future<void> saveForm(FormEntity form) async {
    throw UnimplementedError();
  }
}
