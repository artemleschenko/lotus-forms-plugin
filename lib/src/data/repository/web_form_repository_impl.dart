import 'package:lotus_forms_package/src/domain/domain.dart';

import '../providers/providers.dart';

class WebFormRepositoryImpl implements FormRepository {
  WebFormRepositoryImpl({required this.formProvider});

  final FormProvider formProvider;

  @override
  Future<void> getForms() async {
    return formProvider.getForms();
  }

  @override
  Future<void> getForm(String formId) async {
    return formProvider.getForm(formId);
  }
}
