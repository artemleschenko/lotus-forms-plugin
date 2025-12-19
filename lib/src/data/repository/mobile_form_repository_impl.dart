import 'package:lotus_forms_package/src/data/mappers/form_mapper.dart';
import 'package:lotus_forms_package/src/data/providers/database/database.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';

import '../../core/network/network_info.dart';
import '../providers/providers.dart';

class MobileFormRepositoryImpl implements FormRepository {
  const MobileFormRepositoryImpl({
    required this.formProvider,
    required this.database,
    required this.networkInfo,
  });

  final FormProvider formProvider;
  final Database database;
  final NetworkInfo networkInfo;

  @override
  Future<FormModel> getForm(String formId) async {
    final entity = await formProvider.getForm(formId);
    return FormMapper.transformToModel(entity);
  }

  @override
  Future<List<FormModel>> getForms() async {
    final entities = await formProvider.getForms();
    return entities.map((e) => FormMapper.transformToModel(e)).toList();
  }

  @override
  Future<void> saveForm(FormModel form) async {
    final formEntity = FormMapper.transformToEntity(form);

    if (await networkInfo.isConnected) {
      await formProvider.saveForm(formEntity);
    } else {
      await database.insertForm(formEntity);
    }
  }
}
