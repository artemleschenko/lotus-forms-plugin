import 'package:lotus_forms_package/src/data/mappers/form_mapper.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';

import '../data.dart';
import '../providers/providers.dart';

class WebFormRepositoryImpl implements FormRepository {
  WebFormRepositoryImpl({required this.formProvider});

  final FormProvider formProvider;

  @override
  Future<List<FormModel>> getForms() async {
   final result = await formProvider.getForms();
   return result.map((e) => FormMapper.transformToModel(e)).toList();
  }

  @override
  Future<FormModel> getForm(String formId) async {
    final result = await formProvider.getForm(formId);
    return FormMapper.transformToModel(result);
  }

  @override
  Future<void> saveForm(FormModel form) async {
    throw UnimplementedError();
  }
}
